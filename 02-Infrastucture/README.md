# 📦 CloudChaps Stores – Modular Infrastructure

The goal is to **strengthen networking fundamentals** while following **production-grade patterns**, including:

- Multi-environment deployments (DEV / STAGE / PROD)
- Modular stack separation
- Secure network design (public/private isolation)
- Reusable templates via cross-stack references

---

## 🧱 Architecture Summary


---

## 📁 Project Structure

```bash
01-Infrastructure/
└── 01-CloudFormation/
    ├── templates/
    │   ├── networking/
    │   ├── compute/
    │   └── databases/
    │
    ├── parameters/
    │   ├── dev/
    │   ├── stage/
    │   └── prod/
    │
    ├── scripts/
    │   └── deploy-*.sh
    │
    └── README.md 
02-multi-cloud-infra/
└── environments/
    ├── templates/
    │   ├── dev/
    │   ├── prod/
    │   └── stage/
└── live/
    ├── live/
    │   ├── azure/
    │   ├── gcp/
└── modules/
    ├── azure/
    │   ├── compute/
    │   ├── databases/
    │   ├── networking/
    ├── gcp/
    │   ├── compute/
    │   ├── databases/
    │   ├── networking/
└── README.md/
```

## 🌍 Environments

Environment	Purpose
DEV	    Development and experimentation
STAGE	Pre-production validation
PROD	Production workloads

Each environment uses:

Separate parameter files
Separate CloudFormation stacks
Environment-based naming (${Env})

## 🧩 Components
### 1. Networking
#### VPC
CIDR: 10.0.0.0/23
Enables DNS support and hostnames
Subnets
Type	CIDR	Purpose
Public	10.0.0.0/25	Load balancer, NAT
Public	10.0.0.128/25	High Availability
Private	10.0.1.0/25	App servers
Private	10.0.1.128/25	High Availability
Route Tables
Public → Internet Gateway
Private → NAT Gateway
Internet Gateway
Enables outbound internet access for public subnets
NAT Gateway
Allows private subnets to access the internet securely
### 2. Security
Security Groups (Stateful)
Web SG → Allows HTTP/HTTPS
App SG → Allows internal traffic
DB SG → Allows only app-layer access (e.g., MySQL 3306)
NACLs (Stateless)
Subnet-level filtering
Explicit allow/deny rules
Requires inbound + outbound rules
### 3. VPC Endpoints
Enables private access to AWS services (e.g., S3)
Removes dependency on NAT Gateway for AWS APIs
Improves security and reduces cost
### 4. Load Balancer (ALB)
Internet-facing
Deployed in public subnets
Routes traffic based on path:

```YAML
/        → Frontend
/api/*   → Backend
```

### 5. Compute Layer
EC2 instances (future: autoscaling)
Runs application services
Typically deployed in private subnets
### 6. Database Layer
RDS / Databases
Deployed in private isolated subnets
No internet exposure
DB Subnet Group
Requires at least 2 AZs
Ensures high availability
## 🔗 Cross-Stack References

Stacks export values like:

```YAML
Export:
  Name: DEV-VPC-ID
```
Other stacks import them:

```YAML
Fn::ImportValue: !Sub "${Env}-VPC-ID"
```

## 🧠 Key Networking Concepts Practiced
- CIDR planning and subnetting
- Public vs Private isolation
- NAT vs Internet Gateway behavior
- Stateful vs Stateless filtering
- Load balancing and routing
- Private AWS service access (VPC endpoints)
- Multi-AZ high availability design
## ⚠️ Important Notes
- Some EC2 actions require "Resource": "*" in IAM policies
- Export names must be unique per region/account
- NAT Gateway incurs cost → consider VPC endpoints where possible
- Always deploy in this order:
```BASH
Networking → Security → Database → Compute
```
## 📌 Future Improvements
- Auto Scaling Groups
- HTTPS with ACM
- WAF integration
- CI/CD pipeline (GitHub Actions / Jenkins)
- Terraform version of this project
- Multi-account setup
## 🎯 Purpose of This Project

This project is designed to:

- Strengthen real-world networking skills
- Prepare for Senior DevOps interviews
- Serve as educational content for CloudChaps

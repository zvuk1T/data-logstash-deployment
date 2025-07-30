# ============================================================================
# ROOT MODULE - LOGSTASH DEPLOYMENT
# ============================================================================
# Purpose: Orchestrate networking and compute modules for complete deployment
# Mission: Deploy secure Logstash infrastructure with bastion host architecture
# Pattern: Module composition for enterprise-grade infrastructure
# ============================================================================

# Terraform configuration block
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Optional: Configure remote state backend
  # backend "s3" {
  #   bucket = "your-terraform-state-bucket"
  #   key    = "logstash-deployment/terraform.tfstate"
  #   region = "us-west-2"
  # }
}

# AWS Provider configuration
provider "aws" {
  region = var.aws_region

  # Default tags applied to all resources
  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
      Mission     = "logstash-deployment"
      Engineer    = "data-spock-methodology"
    }
  }
}

# ============================================================================
# NETWORKING MODULE - Foundation Infrastructure
# ============================================================================

module "networking" {
  source = "./modules/networking"

  # Network configuration
  vpc_cidr          = var.vpc_cidr_block
  availability_zone = var.availability_zone

  # Environment and project configuration
  environment  = var.environment
  project_name = var.project_name
}

# ============================================================================
# COMPUTE MODULE - Application Infrastructure
# ============================================================================

module "compute" {
  source = "./modules/compute"

  # Networking inputs from networking module outputs
  vpc_id            = module.networking.vpc_id
  vpc_cidr_block    = module.networking.vpc_cidr_block
  public_subnet_id  = module.networking.public_subnet_id
  private_subnet_id = module.networking.private_subnet_id
  availability_zone = module.networking.availability_zone

  # Instance configuration
  instance_type = var.instance_type
  key_pair_name = var.key_pair_name

  # Security configuration
  allowed_ssh_cidr = var.allowed_ssh_cidr
  logstash_port    = var.logstash_port

  # Environment and project configuration
  environment = var.environment
  project     = var.project_name

  # Module dependency - ensures networking is created first
  depends_on = [module.networking]
}

# ============================================================================
# DEPLOYMENT ARCHITECTURE SUMMARY:
# 
# 1. Networking Module Creates:
#    ├── VPC (10.0.0.0/16)
#    ├── Public Subnet (10.0.1.0/24) 
#    ├── Private Subnet (10.0.2.0/24)
#    ├── Internet Gateway
#    └── Route Tables
# 
# 2. Compute Module Creates:
#    ├── Bastion Host (Public Subnet)
#    ├── Logstash Instance (Private Subnet)
#    ├── Security Groups (Defense-in-Depth)
#    └── SSH Key Associations
# 
# 3. Result: Secure, scalable Logstash deployment
#    Ready for log ingestion and processing
# 
# Live long and prosper! 🖖
# ============================================================================

# ============================================================================
# ROOT MODULE VARIABLES
# ============================================================================
# Purpose: Define input parameters for the complete Logstash deployment
# Usage: Configure deployment settings and resource specifications
# Pattern: Centralized configuration with sensible defaults
# ============================================================================

# AWS Configuration
variable "aws_region" {
  description = "AWS region for resource deployment"
  type        = string
  default     = "us-west-2"

  # Recommended regions for production:
  # - us-west-2 (Oregon) - Lower cost, stable
  # - us-east-1 (Virginia) - Largest service availability
  # - eu-west-1 (Ireland) - European compliance
}

# Network Configuration
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr_block, 0))
    error_message = "VPC CIDR block must be a valid IPv4 CIDR."
  }

  # Default provides 65,536 IP addresses
  # Subnets will use /24 (256 IPs each)
  # Leaves room for future expansion
}

variable "availability_zone" {
  description = "AWS Availability Zone for resource placement"
  type        = string
  default     = "us-west-2a"

  # Must match the selected AWS region
  # Single AZ deployment for cost optimization
  # Can be changed to support multi-AZ in future
}

# Compute Configuration
variable "instance_type" {
  description = "EC2 instance type for bastion and Logstash instances"
  type        = string
  default     = "t3.micro"

  validation {
    condition = contains([
      "t3.micro", "t3.small", "t3.medium", "t3.large",
      "t3a.micro", "t3a.small", "t3a.medium", "t3a.large",
      "m5.large", "m5.xlarge", "c5.large", "c5.xlarge"
    ], var.instance_type)
    error_message = "Instance type must be a valid EC2 instance type."
  }

  # t3.micro: 1 vCPU, 1 GB RAM - Development/testing
  # t3.small: 2 vCPU, 2 GB RAM - Light production
  # t3.medium: 2 vCPU, 4 GB RAM - Standard production
  # Larger instances for high-volume log processing
}

variable "key_pair_name" {
  description = "Name of existing EC2 key pair for SSH access"
  type        = string

  validation {
    condition     = length(var.key_pair_name) > 0
    error_message = "Key pair name cannot be empty."
  }

  # Must be an existing key pair in the target AWS region
  # Create via AWS Console or CLI before deployment:
  # aws ec2 create-key-pair --key-name logstash-deployment --output text --query 'KeyMaterial' > ~/.ssh/logstash-deployment.pem
}

# Security Configuration
variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH to bastion host"
  type        = string
  default     = "0.0.0.0/0"

  validation {
    condition     = can(cidrhost(var.allowed_ssh_cidr, 0))
    error_message = "Allowed SSH CIDR must be a valid IPv4 CIDR."
  }

  # Default allows SSH from anywhere (demo purposes)
  # Production recommendations:
  # - Office network: "203.0.113.0/24"
  # - VPN network: "10.0.0.0/8"
  # - Specific IP: "203.0.113.10/32"
}

variable "logstash_port" {
  description = "Port for Logstash input (Beats/Syslog)"
  type        = number
  default     = 5044

  validation {
    condition     = var.logstash_port >= 1024 && var.logstash_port <= 65535
    error_message = "Logstash port must be between 1024 and 65535."
  }

  # 5044: Standard Elasticsearch Beats input port
  # 5000: Logstash default input port
  # 514: Syslog standard port (requires root privileges)
  # Custom ports: Any available port above 1024
}

# Environment and Project Configuration
variable "environment" {
  description = "Environment name for resource tagging and naming"
  type        = string
  default     = "dev"

  validation {
    condition = contains([
      "dev", "development", "test", "testing",
      "stage", "staging", "prod", "production"
    ], var.environment)
    error_message = "Environment must be one of: dev, development, test, testing, stage, staging, prod, production."
  }

  # Used for:
  # - Resource naming and tagging
  # - Cost allocation and tracking
  # - Environment-specific configurations
}

variable "project_name" {
  description = "Project name for resource tagging and naming"
  type        = string
  default     = "logstash-deployment"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "Project name must contain only lowercase letters, numbers, and hyphens."
  }

  # Used for:
  # - Resource naming conventions
  # - Cost tracking and allocation
  # - Multi-project AWS account management
}

# Advanced Configuration (Optional)
variable "enable_detailed_monitoring" {
  description = "Enable detailed CloudWatch monitoring for EC2 instances"
  type        = bool
  default     = false

  # Detailed monitoring provides 1-minute metrics
  # Standard monitoring provides 5-minute metrics
  # Additional cost applies for detailed monitoring
}

variable "enable_termination_protection" {
  description = "Enable termination protection for EC2 instances"
  type        = bool
  default     = false

  # Prevents accidental instance termination
  # Recommended for production environments
  # Can be disabled via AWS Console when needed
}

# ============================================================================
# VARIABLE DESIGN PRINCIPLES:
# 1. Provide sensible defaults for quick deployment
# 2. Include validation rules for data integrity
# 3. Document all options and recommendations
# 4. Enable both development and production use cases
# 
# Configuration Hierarchy:
# 1. Default values (in this file)
# 2. terraform.tfvars file (user customization)
# 3. Environment variables (TF_VAR_*)
# 4. Command line (-var flag)
# 
# This creates flexible, validated infrastructure configuration
# ============================================================================

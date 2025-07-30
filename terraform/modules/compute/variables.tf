# ============================================================================
# COMPUTE MODULE VARIABLES
# ============================================================================
# Purpose: Define inputs needed to create EC2 instances and security groups
# Usage: These variables will be populated by the root module configuration
# Pattern: Module composition through standardized variable interfaces
# ============================================================================

# Networking Inputs (from networking module outputs)
variable "vpc_id" {
  description = "VPC ID where compute resources will be created"
  type        = string

  # This variable receives the vpc_id output from networking module
  # Enables security groups to be created in the correct VPC
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block for internal security group rules"
  type        = string

  # Used for creating security group rules that allow VPC-internal traffic
  # Enables secure communication within the network boundary
}

variable "public_subnet_id" {
  description = "Public subnet ID for bastion host placement"
  type        = string

  # Bastion host will be deployed here for secure SSH access
  # Must have internet gateway route for external connectivity
}

variable "private_subnet_id" {
  description = "Private subnet ID for Logstash instance placement"
  type        = string

  # Logstash instance deployed here for security isolation
  # No direct internet access - accessed via bastion host
}

variable "availability_zone" {
  description = "Availability zone for consistent instance placement"
  type        = string

  # Ensures all instances are in same AZ for:
  # - EBS volume compatibility
  # - Network latency optimization
  # - Resource locality
}

# Instance Configuration
variable "instance_type" {
  description = "EC2 instance type for compute resources"
  type        = string
  default     = "t3.micro"

  # Default to t3.micro for cost optimization
  # Can be overridden for production workloads
  # Supports both bastion and Logstash instances
}

variable "key_pair_name" {
  description = "Name of existing EC2 key pair for SSH access"
  type        = string

  # Must be an existing key pair in the AWS region
  # Used for both bastion host and Logstash instance
  # Enables secure SSH connectivity
}

# Security Configuration
variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH to bastion host"
  type        = string
  default     = "0.0.0.0/0"

  # Default allows SSH from anywhere (for demo purposes)
  # Should be restricted to specific IP ranges in production
  # Applies only to bastion host (public subnet)
}

variable "logstash_port" {
  description = "Port for Logstash input (beats/syslog)"
  type        = number
  default     = 5044

  # Standard Elasticsearch Beats input port
  # Used for security group rules allowing log ingestion
  # Can be customized based on Logstash configuration
}

# Tagging and Environment
variable "environment" {
  description = "Environment name for resource tagging"
  type        = string
  default     = "dev"

  # Used for consistent resource tagging
  # Enables cost tracking and resource management
  # Examples: dev, staging, prod
}

variable "project" {
  description = "Project name for resource tagging"
  type        = string
  default     = "logstash-deployment"

  # Project identifier for resource organization
  # Enables multi-project AWS account management
  # Used in resource naming and tagging
}

# ============================================================================
# VARIABLE DESIGN PRINCIPLES:
# 1. Accept networking module outputs as inputs
# 2. Provide sensible defaults for optional parameters
# 3. Include validation and description for all variables
# 4. Enable both security and flexibility through configuration
# 
# Data Flow:
# Root Module → Variables → Compute Module → Resources
# This creates configurable, reusable infrastructure components
# ============================================================================

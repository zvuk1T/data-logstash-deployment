# ============================================================================
# NETWORKING MODULE VARIABLES
# ============================================================================
# Purpose: Define input parameters for reusable networking infrastructure
# Usage: Called by root main.tf to create VPC, subnets, and routing
# Security: Implements defense-in-depth with public/private subnet separation
# ============================================================================

variable "project_name" {
  description = "Name prefix for all networking resources (e.g., 'data-logstash')"
  type        = string

  validation {
    condition     = length(var.project_name) > 0 && length(var.project_name) <= 20
    error_message = "Project name must be 1-20 characters for AWS naming limits."
  }
}

variable "vpc_cidr" {
  description = "CIDR block for VPC - defines private IP address space (e.g., '10.0.0.0/16')"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "VPC CIDR must be a valid IPv4 CIDR block."
  }
}

variable "availability_zone" {
  description = "AWS AZ for subnet placement - ensures regional deployment (e.g., 'us-east-1a')"
  type        = string
  default     = "us-east-1a"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet - for bastion host with internet access"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for private subnet - for Logstash instance (no direct internet)"
  type        = string
  default     = "10.0.2.0/24"
}

variable "environment" {
  description = "Environment tag for resource organization (dev/staging/prod)"
  type        = string
  default     = "development"
}

# ============================================================================
# VARIABLE DESIGN NOTES:
# - validation blocks ensure proper input format and AWS compliance
# - defaults enable easy module usage while allowing customization
# - descriptions provide clear guidance for module consumers
# - type constraints prevent configuration errors
# ============================================================================

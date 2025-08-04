# ============================================================================
# ROOT MODULE OUTPUTS
# ============================================================================
# Purpose: Expose key deployment information for users and external systems
# Usage: Provides connection details, endpoints, and infrastructure summary
# Pattern: Aggregated outputs from networking and compute modules
# ============================================================================

# Connection Information - Ready-to-Use Commands
output "ssh_to_bastion" {
  description = "SSH command to connect to bastion host"
  value       = module.compute.ssh_connection_command

  # This provides a ready-to-use SSH command
  # No need to look up IP addresses manually
  # Example: ssh -i ~/.ssh/key.pem ec2-user@54.123.45.67
}

output "ssh_to_logstash" {
  description = "SSH command to reach Logstash instance via bastion"
  value       = module.compute.logstash_ssh_via_bastion

  # Jump host command for secure access to private instance
  # Uses SSH ProxyJump feature for seamless connection
  # Example: ssh -i ~/.ssh/key.pem -J ec2-user@54.123.45.67 ec2-user@10.0.2.10
}

# Service Endpoints
output "logstash_endpoint" {
  description = "Logstash service endpoint for log forwarding"
  value       = module.compute.logstash_endpoint

  # Use this endpoint in your log shipper configuration
  # Example: 10.0.2.10:5044 for Filebeat or Fluentd
  # Only accessible from within the VPC for security
}

output "bastion_public_ip" {
  description = "Public IP address of bastion host"
  value       = module.compute.bastion_public_ip

  # Public IP for SSH access and documentation
  # Use for firewall rules or DNS configuration
  # Changes when instance is stopped/started
}

# Infrastructure Overview
output "deployment_summary" {
  description = "Complete infrastructure deployment summary"
  value = {
    # Networking information
    vpc_id            = module.networking.vpc_id
    vpc_cidr          = module.networking.vpc_cidr_block
    public_subnet_id  = module.networking.public_subnet_id
    private_subnet_id = module.networking.private_subnet_id
    availability_zone = module.networking.availability_zone

    # Compute information
    bastion_instance_id  = module.compute.bastion_instance_id
    bastion_public_ip    = module.compute.bastion_public_ip
    bastion_private_ip   = module.compute.bastion_private_ip
    logstash_instance_id = module.compute.logstash_instance_id
    logstash_private_ip  = module.compute.logstash_private_ip

    # Service information
    logstash_port   = var.logstash_port
    ssh_access_from = var.allowed_ssh_cidr

    # Environment metadata
    environment = var.environment
    project     = var.project_name
    aws_region  = var.aws_region
  }

  # This provides a complete deployment overview
  # Useful for documentation and troubleshooting
  # Contains all critical infrastructure information
}

# Security Information
output "security_groups" {
  description = "Security group IDs for reference and modification"
  value = {
    bastion_sg_id  = module.compute.bastion_security_group_id
    logstash_sg_id = module.compute.logstash_security_group_id
  }

  # Security group IDs for future modifications
  # Use these to add additional rules if needed
  # Reference for compliance and security auditing
}

# Health Monitoring Endpoints
output "monitoring_endpoints" {
  description = "Endpoints for health monitoring and troubleshooting"
  value       = module.compute.instance_health_check_urls

  # Use these endpoints for monitoring systems
  # Configure health checks and alerting
  # Network connectivity validation
}

# Quick Start Guide
output "quick_start_guide" {
  description = "Quick start commands and configuration examples"
  value = {
    # Connection commands
    ssh_bastion  = module.compute.ssh_connection_command
    ssh_logstash = module.compute.logstash_ssh_via_bastion

    # Logstash configuration
    logstash_endpoint = module.compute.logstash_endpoint
    beats_config      = "output.logstash:\n  hosts: [\"${module.compute.logstash_endpoint}\"]"

    # Network information
    vpc_cidr       = module.networking.vpc_cidr_block
    public_subnet  = module.networking.public_subnet_cidr
    private_subnet = module.networking.private_subnet_cidr
    nat_gateway_ip = module.networking.nat_gateway_public_ip

    # Next steps
    next_steps = [
      "1. Connect to bastion: ${module.compute.ssh_connection_command}",
      "2. Connect to Logstash: ${module.compute.logstash_ssh_via_bastion}",
      "3. Configure log shippers to send to: ${module.compute.logstash_endpoint}",
      "4. Monitor instance health and performance",
      "5. Configure Logstash pipelines and outputs"
    ]
  }

  # Complete quick start information
  # Everything needed to begin using the deployment
  # Step-by-step guidance for users
}

# Terraform State Information
output "terraform_workspace_info" {
  description = "Terraform workspace and state information"
  value = {
    workspace        = terraform.workspace
    region           = var.aws_region
    project          = var.project_name
    environment      = var.environment
    modules_deployed = ["networking", "compute"]
  }

  # Terraform metadata for operational visibility
  # Workspace information for multi-environment management
  # Module tracking for dependency analysis
}

# ============================================================================
# OUTPUT DESIGN PRINCIPLES:
# 1. Provide ready-to-use commands and endpoints
# 2. Aggregate information from all modules
# 3. Include operational and troubleshooting data
# 4. Enable automation and monitoring integration
# 
# Usage Examples:
# - terraform output ssh_to_bastion
# - terraform output deployment_summary
# - terraform output -json | jq '.quick_start_guide.value'
# 
# This creates a complete operational interface for the infrastructure
# Live long and prosper! 🖖
# ============================================================================

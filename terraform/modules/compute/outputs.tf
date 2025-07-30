# ============================================================================
# COMPUTE MODULE OUTPUTS
# ============================================================================
# Purpose: Export compute resources for external reference and monitoring
# Usage: Root module and future modules can reference these outputs
# Pattern: Resource discovery and infrastructure introspection
# ============================================================================

# Bastion Host Outputs
output "bastion_instance_id" {
  description = "ID of the bastion host instance"
  value       = aws_instance.bastion.id

  # This output enables:
  # - Instance monitoring and management
  # - CloudWatch metrics configuration
  # - Backup and snapshot automation
}

output "bastion_public_ip" {
  description = "Public IP address of bastion host for SSH access"
  value       = aws_instance.bastion.public_ip

  # This output provides:
  # - SSH connection endpoint for users
  # - DNS record configuration
  # - Network access documentation
}

output "bastion_private_ip" {
  description = "Private IP address of bastion host within VPC"
  value       = aws_instance.bastion.private_ip

  # This output enables:
  # - Internal network routing configuration
  # - Security group rule references
  # - Network monitoring and analysis
}

output "bastion_security_group_id" {
  description = "ID of bastion host security group"
  value       = aws_security_group.bastion.id

  # This output enables:
  # - Security group rule modifications
  # - Compliance auditing and validation
  # - Additional security group associations
}

# Logstash Instance Outputs
output "logstash_instance_id" {
  description = "ID of the Logstash instance"
  value       = aws_instance.logstash.id

  # This output enables:
  # - Instance lifecycle management
  # - Performance monitoring setup
  # - Automated backup configuration
}

output "logstash_private_ip" {
  description = "Private IP address of Logstash instance"
  value       = aws_instance.logstash.private_ip

  # This output provides:
  # - Logstash endpoint for log forwarding
  # - Application configuration references
  # - Network troubleshooting information
}

output "logstash_security_group_id" {
  description = "ID of Logstash security group"
  value       = aws_security_group.logstash.id

  # This output enables:
  # - Additional security rule configuration
  # - Security compliance validation
  # - Network access control management
}

# Connection Information
output "ssh_connection_command" {
  description = "SSH command to connect to bastion host"
  value       = "ssh -i ~/.ssh/${var.key_pair_name}.pem ec2-user@${aws_instance.bastion.public_ip}"

  # This output provides:
  # - Ready-to-use SSH command for users
  # - Documentation and user guides
  # - Automated connection scripts
}

output "logstash_ssh_via_bastion" {
  description = "SSH command to reach Logstash via bastion host"
  value       = "ssh -i ~/.ssh/${var.key_pair_name}.pem -J ec2-user@${aws_instance.bastion.public_ip} ec2-user@${aws_instance.logstash.private_ip}"

  # This output provides:
  # - Jump host SSH command for Logstash access
  # - Administrative access documentation
  # - Troubleshooting connection guidance
}

# Service Endpoints
output "logstash_endpoint" {
  description = "Logstash service endpoint for log ingestion"
  value       = "${aws_instance.logstash.private_ip}:${var.logstash_port}"

  # This output provides:
  # - Application configuration endpoint
  # - Log forwarding destination
  # - Service discovery information
}

# Infrastructure Summary
output "deployment_summary" {
  description = "Summary of deployed infrastructure"
  value = {
    bastion_host = {
      instance_id = aws_instance.bastion.id
      public_ip   = aws_instance.bastion.public_ip
      private_ip  = aws_instance.bastion.private_ip
      purpose     = "SSH Gateway and Jump Host"
    }
    logstash_server = {
      instance_id  = aws_instance.logstash.id
      private_ip   = aws_instance.logstash.private_ip
      service_port = var.logstash_port
      purpose      = "Log Processing and Analysis"
    }
    security = {
      bastion_sg_id  = aws_security_group.bastion.id
      logstash_sg_id = aws_security_group.logstash.id
      access_pattern = "Internet → Bastion → Logstash"
    }
  }

  # This output provides:
  # - Complete infrastructure overview
  # - Operational documentation
  # - Troubleshooting reference
}

# Monitoring and Health Check Outputs
output "instance_health_check_urls" {
  description = "Health check endpoints for monitoring"
  value = {
    bastion_ping  = aws_instance.bastion.private_ip
    logstash_ping = aws_instance.logstash.private_ip
    logstash_port = "${aws_instance.logstash.private_ip}:${var.logstash_port}"
  }

  # This output enables:
  # - Automated health monitoring
  # - Service discovery configuration
  # - Network connectivity validation
}

# Resource Tags Summary
output "resource_tags" {
  description = "Common tags applied to all resources"
  value = {
    Environment = var.environment
    Project     = var.project
    Module      = "compute"
    ManagedBy   = "terraform"
  }

  # This output provides:
  # - Tag consistency validation
  # - Cost allocation tracking
  # - Resource organization reference
}

# ============================================================================
# OUTPUT DESIGN PRINCIPLES:
# 1. Export all resources that external systems might need
# 2. Provide both technical IDs and human-readable information
# 3. Include ready-to-use commands and endpoints
# 4. Enable monitoring, troubleshooting, and documentation
# 
# Usage Examples:
# - Root module: module.compute.bastion_public_ip
# - Monitoring: module.compute.instance_health_check_urls
# - Documentation: module.compute.deployment_summary
# 
# This creates a complete interface for infrastructure management
# and operational visibility. Live long and prosper! 🖖
# ============================================================================

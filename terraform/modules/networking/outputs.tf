# ============================================================================
# NETWORKING MODULE OUTPUTS
# ============================================================================
# Purpose: Export networking resources for use by other modules
# Usage: Compute module will reference these outputs for instance placement
# Pattern: Module composition through input/output relationships
# ============================================================================

output "vpc_id" {
  description = "ID of the created VPC - used by security groups and instances"
  value       = aws_vpc.main.id

  # This output enables other modules to:
  # - Create security groups in this VPC
  # - Reference VPC for resource placement
  # - Ensure consistent network boundaries
}

output "vpc_cidr_block" {
  description = "CIDR block of VPC - used for security group rules"
  value       = aws_vpc.main.cidr_block

  # This output enables:
  # - Security group rules referencing VPC traffic
  # - Network ACL configurations
  # - Internal traffic validation
}

output "public_subnet_id" {
  description = "ID of public subnet - for bastion host placement"
  value       = aws_subnet.public.id

  # This output enables:
  # - Bastion host deployment in internet-accessible subnet
  # - Load balancer placement (if needed)
  # - NAT gateway placement (future expansion)
}

output "private_subnet_id" {
  description = "ID of private subnet - for Logstash instance placement"
  value       = aws_subnet.private.id

  # This output enables:
  # - Secure application deployment
  # - Database placement (future expansion)
  # - Internal service deployment
}

output "public_subnet_cidr" {
  description = "CIDR block of public subnet - for security group rules"
  value       = aws_subnet.public.cidr_block

  # This output enables:
  # - Security group rules allowing bastion access
  # - Network monitoring and analysis
  # - Traffic flow validation
}

output "private_subnet_cidr" {
  description = "CIDR block of private subnet - for security group rules"
  value       = aws_subnet.private.cidr_block

  # This output enables:
  # - Internal security group rules
  # - Application-to-application communication
  # - Database access rules (future)
}

output "internet_gateway_id" {
  description = "ID of internet gateway - for reference and validation"
  value       = aws_internet_gateway.main.id

  # This output enables:
  # - Route table validation
  # - Network monitoring
  # - Troubleshooting connectivity
}

output "nat_gateway_id" {
  description = "ID of NAT Gateway - for outbound internet access from private subnet"
  value       = aws_nat_gateway.main.id

  # This output enables:
  # - Route table validation
  # - Network monitoring and troubleshooting
  # - Cost tracking and optimization
}

output "nat_gateway_public_ip" {
  description = "Public IP of NAT Gateway - for allowlist configurations"
  value       = aws_eip.nat_gateway.public_ip

  # This output enables:
  # - External service allowlist configuration
  # - Network security monitoring
  # - Outbound traffic source identification
}

output "availability_zone" {
  description = "AZ where subnets were created - for instance placement consistency"
  value       = var.availability_zone

  # This output ensures:
  # - Consistent AZ placement across modules
  # - EBS volume compatibility
  # - Network latency optimization
}

# ============================================================================
# OUTPUT DESIGN PRINCIPLES:
# 1. Export all resources other modules might need
# 2. Include both IDs (for reference) and values (for rules)
# 3. Provide clear descriptions for module consumers
# 4. Enable flexible module composition patterns
# 
# Module Composition Example:
# Networking Module → Outputs → Compute Module → Inputs
# This creates a clear dependency chain and reusable architecture
# ============================================================================

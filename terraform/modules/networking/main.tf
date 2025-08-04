# ============================================================================
# NETWORKING MODULE - MAIN INFRASTRUCTURE
# ============================================================================
# Purpose: Create foundational networking for secure multi-tier architecture
# Security: Public subnet for bastion, private subnet for applications
# Architecture: VPC → Subnets → Internet Gateway → Route Tables → Routes
# ============================================================================

# VPC: Virtual Private Cloud - Our isolated network environment
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true # Required for bastion SSH access
  enable_dns_support   = true # Required for AWS service integration

  tags = {
    Name        = "${var.project_name}-vpc"
    Environment = var.environment
    Purpose     = "Mission 107 Logstash Deployment"
    Security    = "Multi-tier network isolation"
  }
}

### Your private route table needs a NAT gateway or NAT instance to allow outbound internet access for the private subnet(Mainly for updates in the server).

# Internet Gateway: Enables public subnet internet access for bastion
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.project_name}-igw"
    Environment = var.environment
    Purpose     = "Public subnet internet access"
  }
}

# Elastic IP for NAT Gateway: Required for stable public IP
resource "aws_eip" "nat_gateway" {
  domain = "vpc"
  
  tags = {
    Name        = "${var.project_name}-nat-gateway-eip"
    Environment = var.environment
    Purpose     = "NAT Gateway stable IP"
  }
  
  depends_on = [aws_internet_gateway.main]
}

# NAT Gateway: Enables private subnet outbound internet access
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public.id
  
  tags = {
    Name        = "${var.project_name}-nat-gateway"
    Environment = var.environment
    Purpose     = "Private subnet internet access"
  }
  
  depends_on = [aws_internet_gateway.main]
}

# PUBLIC SUBNET: For bastion host (internet-accessible)
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true # Auto-assign public IPs for instances

  tags = {
    Name        = "${var.project_name}-public-subnet"
    Environment = var.environment
    Type        = "Public"
    Purpose     = "Bastion host deployment"
    Security    = "Internet accessible - bastion only"
  }
}

# PRIVATE SUBNET: For Logstash instance (no inbound internet, outbound via NAT Gateway)
resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = false # No public IPs for security

  tags = {
    Name        = "${var.project_name}-private-subnet"
    Environment = var.environment
    Type        = "Private"
    Purpose     = "Logstash application deployment"
    Security    = "Access via bastion only"
  }
}

# PUBLIC ROUTE TABLE: Routes traffic from public subnet to internet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.project_name}-public-rt"
    Environment = var.environment
    Purpose     = "Public subnet internet routing"
  }
}

# PUBLIC ROUTE: Default route to internet gateway
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0" # All traffic not in VPC
  gateway_id             = aws_internet_gateway.main.id
}

# PUBLIC ROUTE TABLE ASSOCIATION: Connect public subnet to public routing
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# PRIVATE ROUTE TABLE: Routes private subnet traffic through NAT Gateway
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.project_name}-private-rt"
    Environment = var.environment
    Purpose     = "Private subnet with NAT Gateway access"
    Security    = "Outbound internet via NAT Gateway"
  }
}

# Route for private subnet internet access through NAT Gateway
resource "aws_route" "private_internet_access" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

# PRIVATE ROUTE TABLE ASSOCIATION: Connect private subnet to isolated routing
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# ============================================================================
# ARCHITECTURE SUMMARY:
# VPC (10.0.0.0/16)
# ├── Public Subnet (10.0.1.0/24) → Internet Gateway → Internet
# └── Private Subnet (10.0.2.0/24) → NAT Gateway → Internet Gateway → Internet
#
# Security Model: Defense-in-depth with network isolation + outbound access
# Access Pattern: Internet → Bastion (public) → Logstash (private)
# Outbound Pattern: Logstash (private) → NAT Gateway (public) → Internet
# ============================================================================

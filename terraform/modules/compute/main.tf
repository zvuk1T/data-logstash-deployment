# ============================================================================
# COMPUTE MODULE MAIN CONFIGURATION
# ============================================================================
# Purpose: Create EC2 instances and security groups for Logstash deployment
# Dependencies: Networking module outputs via variables
# Pattern: Defense-in-depth security with bastion host architecture
# ============================================================================

# Data source for latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # This ensures we use the latest stable Amazon Linux 2 AMI
  # Amazon Linux 2 provides security updates and Docker support
  # Perfect for both bastion host and Logstash deployment
}

# ============================================================================
# SECURITY GROUPS - Defense in Depth Architecture
# ============================================================================

# Bastion Host Security Group - Internet-facing with restricted access
resource "aws_security_group" "bastion" {
  name_prefix = "${var.project}-${var.environment}-bastion-"
  description = "Security group for bastion host - SSH gateway"
  vpc_id      = var.vpc_id

  # Inbound Rules - SSH access from specified CIDR
  ingress {
    description = "SSH access to bastion host"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]

    # This rule allows SSH from external networks
    # In production, restrict allowed_ssh_cidr to specific IP ranges
    # Default allows 0.0.0.0/0 for demo purposes
  }

  # Outbound Rules - Allow all outbound (for package installation, etc.)
  egress {
    description = "All outbound traffic from bastion"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

    # Bastion needs outbound access for:
    # - Package updates (yum/apt)
    # - SSH to private instances
    # - Internet connectivity for maintenance
  }

  tags = {
    Name        = "${var.project}-${var.environment}-bastion-sg"
    Environment = var.environment
    Project     = var.project
    Type        = "security-group"
    Purpose     = "bastion-host"
  }
}

# Logstash Security Group - Private subnet with controlled access
resource "aws_security_group" "logstash" {
  name_prefix = "${var.project}-${var.environment}-logstash-"
  description = "Security group for Logstash instance - log processing"
  vpc_id      = var.vpc_id

  # Inbound Rules - SSH from bastion host only
  ingress {
    description     = "SSH from bastion host"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]

    # Only bastion host can SSH to Logstash instance
    # This implements the jump box security pattern
    # No direct SSH access from internet
  }

  # Inbound Rules - Logstash input port from VPC
  ingress {
    description = "Logstash Beats input from VPC"
    from_port   = var.logstash_port
    to_port     = var.logstash_port
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]

    # Allows log ingestion from any VPC resource
    # Port 5044 is standard for Elasticsearch Beats
    # Restricted to VPC CIDR for internal security
  }

  # Inbound Rules - Allow ICMP for network troubleshooting
  ingress {
    description = "ICMP ping from VPC for troubleshooting"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.vpc_cidr_block]

    # Enables ping for network diagnostics
    # Restricted to VPC internal traffic only
    # Useful for connectivity testing
  }

  # Outbound Rules - Allow all outbound for package installation
  egress {
    description = "All outbound traffic for updates and logs"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

    # Logstash instance needs outbound access for:
    # - Package installation and updates
    # - Elasticsearch/log forwarding (future)
    # - Time synchronization (NTP)
  }

  tags = {
    Name        = "${var.project}-${var.environment}-logstash-sg"
    Environment = var.environment
    Project     = var.project
    Type        = "security-group"
    Purpose     = "logstash-instance"
  }
}

# ============================================================================
# EC2 INSTANCES - Bastion Host and Logstash Server
# ============================================================================

# Bastion Host - SSH Gateway in Public Subnet
resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.bastion.id]
  availability_zone      = var.availability_zone

  # Enable public IP for internet access
  associate_public_ip_address = true

  # User data script for initial setup
  user_data = base64encode(<<-EOF
              #!/bin/bash
              # Update system packages
              yum update -y
              
              # Install useful tools for bastion host
              yum install -y htop tree wget curl
              
              # Configure SSH for forwarding (optional)
              echo "AllowTcpForwarding yes" >> /etc/ssh/sshd_config
              echo "GatewayPorts no" >> /etc/ssh/sshd_config
              systemctl restart sshd
              
              # Create banner for SSH users
              echo "================================================" > /etc/motd
              echo "  BASTION HOST - ${var.project} ${var.environment}" >> /etc/motd
              echo "  Use this host to access private resources" >> /etc/motd
              echo "  Live long and prosper! 🖖" >> /etc/motd
              echo "================================================" >> /etc/motd
              EOF
  )

  tags = {
    Name        = "${var.project}-${var.environment}-bastion"
    Environment = var.environment
    Project     = var.project
    Type        = "ec2-instance"
    Purpose     = "bastion-host"
    Role        = "gateway"
  }
}

# Logstash Instance - Log Processing in Private Subnet
resource "aws_instance" "logstash" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [aws_security_group.logstash.id]
  availability_zone      = var.availability_zone

  # No public IP - private subnet only
  associate_public_ip_address = false

  # User data script for Logstash setup
  user_data = base64encode(<<-EOF
              #!/bin/bash
              # Update system packages
              yum update -y
              
              # Install Java (required for Logstash)
              yum install -y java-11-openjdk java-11-openjdk-devel
              
              # Install Docker for containerized Logstash
              yum install -y docker
              systemctl start docker
              systemctl enable docker
              usermod -a -G docker ec2-user
              
              # Install useful monitoring tools
              yum install -y htop tree wget curl netstat-nat
              
              # Create Logstash configuration directory
              mkdir -p /opt/logstash/config
              mkdir -p /opt/logstash/logs
              chown -R ec2-user:ec2-user /opt/logstash
              
              # Create banner with Spock greeting
              echo "================================================" > /etc/motd
              echo "  LOGSTASH SERVER - ${var.project} ${var.environment}" >> /etc/motd
              echo "  Log processing and analysis platform" >> /etc/motd
              echo "  Port ${var.logstash_port} ready for Beats input" >> /etc/motd
              echo "  Fascinating! 🖖" >> /etc/motd
              echo "================================================" >> /etc/motd
              EOF
  )

  tags = {
    Name        = "${var.project}-${var.environment}-logstash"
    Environment = var.environment
    Project     = var.project
    Type        = "ec2-instance"
    Purpose     = "log-processing"
    Role        = "logstash-server"
  }
}

# ============================================================================
# ARCHITECTURE SUMMARY:
# 
# Public Subnet (10.0.1.0/24):
# ├── Bastion Host (with public IP)
# │   ├── SSH access from var.allowed_ssh_cidr
# │   └── Can SSH to Logstash instance
# 
# Private Subnet (10.0.2.0/24):
# ├── Logstash Instance (no public IP)
# │   ├── SSH access from bastion only
# │   ├── Logstash port 5044 from VPC
# │   └── No direct internet access
# 
# Security Philosophy:
# - Defense in depth with network isolation
# - Principle of least privilege for access
# - Bastion host as single point of entry
# - Application security through VPC boundaries
# ============================================================================

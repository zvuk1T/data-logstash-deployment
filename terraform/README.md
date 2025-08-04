# 🚀 **Logstash Deployment Infrastructure**
## **Mission #107: Enterprise-Grade Modular Terraform Architecture**

**📅 Created:** 30.07.2025  
**🔄 Enhanced:** 04.08.2025 (NAT Gateway Integration)  
**🎯 Purpose:** Production-ready Logstash infrastructure with modular architecture  
**🏗️ Architecture:** Defense-in-depth security with NAT Gateway enhancement  
**🛡️ Security Model:** Network isolation + controlled outbound access

---

## 🎯 **OVERVIEW**

This Terraform configuration deploys a secure, production-ready Logstash infrastructure on AWS using a **modular architecture** with **defense-in-depth security principles** and **NAT Gateway enhancement** for operational capability.

## 🏗️ **ARCHITECTURE (Enhanced with NAT Gateway)**

```
Enhanced Infrastructure Architecture:
┌─────────────────────────────────────────────────────────────┐
│                    Internet Gateway                         │
└─────────────────────┬───────────────────────────────────────┘
                      │
┌─────────────────────────────────────────────────────────────┐
│                 VPC (10.0.0.0/16)                          │
│                                                             │
│  ┌─────────────────────────┐  ┌─────────────────────────┐   │
│  │   Public Subnet         │  │   Private Subnet        │   │
│  │   (10.0.1.0/24)        │  │   (10.0.2.0/24)        │   │
│  │                         │  │                         │   │
│  │  ┌─────────────────┐   │  │  ┌─────────────────┐    │   │
│  │  │  Bastion Host   │   │  │  │ Logstash Server │    │   │
│  │  │  (SSH Gateway)  │◄──┼──┼──┤ (Log Processing)│    │   │
│  │  │  Public IP      │   │  │  │ Private IP Only │    │   │
│  │  └─────────────────┘   │  │  └─────────────────┘    │   │
│  │                         │  │           │             │   │
│  │  ┌─────────────────┐   │  │           ▼             │   │
│  │  │   NAT Gateway   │◄──┼──┼───────────┘             │   │
│  │  │ (Outbound Only) │   │  │                         │   │
│  │  └─────────────────┘   │  │                         │   │
│  └─────────────────────────┘  └─────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘

Traffic Flows:
├── Inbound: Internet → Bastion Host → Logstash (Secure Management)
└── Outbound: Logstash → NAT Gateway → Internet (Updates/Packages)
```

## 🛡️ **Security Features (Enhanced)**

- **Network Isolation**: Private subnet with no inbound internet access
- **Controlled Outbound**: NAT Gateway enables private subnet updates/packages
- **Bastion Host**: Secure SSH gateway for administrative access
- **Defense in Depth**: Multiple security layers with least privilege
- **Security Groups**: Granular network access control
- **Encrypted Transit**: SSH key-based authentication
- **Ansible-Ready**: User Data prepared for automation replacement

## Prerequisites

### Required Tools

1. **Terraform** (>= 1.0)
   ```bash
   # Install via package manager or download from terraform.io
   terraform --version
   ```

2. **AWS CLI** (configured with credentials)
   ```bash
   aws configure
   aws sts get-caller-identity  # Verify credentials
   ```

3. **EC2 Key Pair** (in target AWS region)
   ```bash
   # Create new key pair
   aws ec2 create-key-pair --key-name logstash-deployment --output text --query 'KeyMaterial' > ~/.ssh/logstash-deployment.pem
   chmod 400 ~/.ssh/logstash-deployment.pem
   ```

### Required AWS Permissions

Your AWS credentials need the following permissions:
- EC2: Full access for instances, security groups, key pairs
- VPC: Full access for VPC, subnets, route tables, internet gateways
- IAM: Limited access for resource tagging and policies

## Quick Start

### 1. Configuration

```bash
# Clone and navigate to terraform directory
cd terraform/

# Copy and customize configuration
cp terraform.tfvars.example terraform.tfvars
nano terraform.tfvars  # Edit with your values
```

### 2. Deployment

```bash
# Initialize Terraform
terraform init

# Review planned changes
terraform plan

# Deploy infrastructure
terraform apply
```

### 3. Connect and Verify

```bash
# Get connection commands (after deployment)
terraform output ssh_to_bastion
terraform output ssh_to_logstash

# Connect to bastion host
$(terraform output -raw ssh_to_bastion)

# Connect to Logstash server via bastion
$(terraform output -raw ssh_to_logstash)
```

## Configuration Guide

### Basic Configuration (terraform.tfvars)

```hcl
# Essential settings for deployment
aws_region        = "eu-central-1"
availability_zone = "eu-central-1a"
key_pair_name    = "your-key-pair-name"
allowed_ssh_cidr = "203.0.113.0/24"  # Your office network
environment      = "production"
project_name     = "logstash-deployment"
```

### Advanced Configuration

```hcl
# Performance tuning
instance_type = "t3.medium"  # Larger instances for production

# Security hardening
allowed_ssh_cidr = "10.0.0.0/8"  # Corporate VPN only
enable_termination_protection = true

# Monitoring
enable_detailed_monitoring = true
```

### Network Customization

```hcl
# Custom network ranges
vpc_cidr_block = "172.16.0.0/16"  # Avoid conflicts

# Different availability zone
availability_zone = "eu-central-1b"
```

## Usage Examples

### Connecting to Infrastructure

```bash
# SSH to bastion host (internet-accessible)
ssh -i ~/.ssh/logstash-deployment.pem ec2-user@<bastion-public-ip>

# SSH to Logstash server (via bastion)
ssh -i ~/.ssh/logstash-deployment.pem -J ec2-user@<bastion-public-ip> ec2-user@<logstash-private-ip>

# Port forwarding for web interfaces
ssh -i ~/.ssh/logstash-deployment.pem -L 9600:10.0.2.10:9600 ec2-user@<bastion-public-ip>
```

### Configuring Log Shippers

#### Filebeat Configuration

```yaml
# /etc/filebeat/filebeat.yml
output.logstash:
  hosts: ["10.0.2.10:5044"]

filebeat.inputs:
- type: log
  paths:
    - /var/log/*.log
```

#### Fluentd Configuration

```ruby
# /etc/td-agent/td-agent.conf
<match **>
  @type forward
  <server>
    host 10.0.2.10
    port 5044
  </server>
</match>
```

### Logstash Configuration

```ruby
# /opt/logstash/config/logstash.conf
input {
  beats {
    port => 5044
  }
}

filter {
  if [type] == "syslog" {
    grok {
      match => { "message" => "%{SYSLOGTIMESTAMP:timestamp} %{GREEDYDATA:message}" }
    }
  }
}

output {
  elasticsearch {
    hosts => ["your-elasticsearch-cluster:9200"]
    index => "logs-%{+YYYY.MM.dd}"
  }
}
```

## Operational Tasks

### Health Monitoring

```bash
# Check instance status
aws ec2 describe-instances --instance-ids <instance-id>

# Monitor Logstash service
ssh -J ec2-user@<bastion-ip> ec2-user@<logstash-ip> "sudo systemctl status logstash"

# Check Logstash logs
ssh -J ec2-user@<bastion-ip> ec2-user@<logstash-ip> "sudo tail -f /var/log/logstash/logstash-plain.log"
```

### Performance Tuning

```bash
# Monitor resource usage
ssh -J ec2-user@<bastion-ip> ec2-user@<logstash-ip> "htop"

# Check network connectivity
ssh -J ec2-user@<bastion-ip> ec2-user@<logstash-ip> "netstat -tlnp | grep 5044"

# Test log ingestion
echo "test log message" | nc <logstash-private-ip> 5044
```

### Backup and Recovery

```bash
# Create instance snapshots
aws ec2 create-snapshot --volume-id <volume-id> --description "Logstash backup $(date)"

# Backup Logstash configuration
scp -J ec2-user@<bastion-ip> ec2-user@<logstash-ip>:/opt/logstash/config/* ./backup/
```

## Troubleshooting

### Common Issues

#### SSH Connection Failed

```bash
# Check security group rules
aws ec2 describe-security-groups --group-ids <sg-id>

# Verify key pair permissions
ls -la ~/.ssh/logstash-deployment.pem  # Should be 400

# Test connectivity
telnet <bastion-public-ip> 22
```

#### Logstash Not Receiving Logs

```bash
# Check Logstash service status
sudo systemctl status logstash

# Verify port binding
sudo netstat -tlnp | grep 5044

# Check security group rules
aws ec2 describe-security-groups --group-ids <logstash-sg-id>

# Test port connectivity from bastion
telnet <logstash-private-ip> 5044
```

#### Instance Launch Failed

```bash
# Check subnet capacity
aws ec2 describe-subnets --subnet-ids <subnet-id>

# Verify key pair exists
aws ec2 describe-key-pairs --key-names <key-name>

# Check IAM permissions
aws iam simulate-principal-policy --policy-source-arn <user-arn> --action-names ec2:RunInstances
```

### Log Analysis

```bash
# System logs
sudo tail -f /var/log/messages

# Logstash logs
sudo tail -f /var/log/logstash/logstash-plain.log

# Application logs
sudo journalctl -u logstash -f
```

## Module Structure

```
terraform/
├── main.tf                     # Root module orchestration
├── variables.tf                # Input parameters
├── outputs.tf                  # Deployment results
├── terraform.tfvars.example    # Configuration template
├── README.md                   # This documentation
└── modules/
    ├── networking/             # VPC and network resources
    │   ├── main.tf
    │   ├── variables.tf
    │   ├── outputs.tf
    │   └── README.md
    └── compute/                # EC2 instances and security
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf
        └── README.md
```

## Security Best Practices

### Production Recommendations

1. **Network Security**
   - Restrict `allowed_ssh_cidr` to specific IP ranges
   - Enable VPC Flow Logs for network monitoring
   - Use AWS Systems Manager Session Manager for keyless access

2. **Instance Security**
   - Enable termination protection
   - Configure automated patching
   - Implement disk encryption
   - Regular security updates

3. **Access Management**
   - Use IAM roles instead of access keys
   - Implement least privilege principles
   - Enable CloudTrail for API logging
   - Regular access reviews

4. **Monitoring and Alerting**
   - Enable detailed CloudWatch monitoring
   - Set up alerting for instance health
   - Monitor log ingestion rates
   - Configure log retention policies

## Cost Optimization

### Development Environment

```hcl
instance_type = "t3.micro"              # Free tier eligible
enable_detailed_monitoring = false      # Standard monitoring only
enable_termination_protection = false   # Easy cleanup
```

### Production Environment

```hcl
instance_type = "t3.medium"             # Better performance
enable_detailed_monitoring = true       # Enhanced monitoring
enable_termination_protection = true    # Prevent accidents
```

## Scaling Considerations

### Horizontal Scaling

- Deploy multiple Logstash instances across availability zones
- Use Application Load Balancer for log distribution
- Implement Auto Scaling Groups for elasticity

### Vertical Scaling

- Upgrade instance types based on CPU/memory utilization
- Monitor JVM heap usage for Logstash optimization
- Consider memory-optimized instances for large datasets

## Integration Examples

### ELK Stack Integration

```ruby
# Logstash output to Elasticsearch
output {
  elasticsearch {
    hosts => ["elasticsearch-cluster.example.com:9200"]
    index => "logs-%{+YYYY.MM.dd}"
    template_overwrite => true
  }
}
```

### Kafka Integration

```ruby
# Logstash input from Kafka
input {
  kafka {
    bootstrap_servers => "kafka-cluster.example.com:9092"
    topics => ["application-logs"]
    group_id => "logstash-consumer"
  }
}
```

## Support and Maintenance

### Regular Maintenance Tasks

1. **Weekly**: Review CloudWatch metrics and logs
2. **Monthly**: Apply security patches and updates
3. **Quarterly**: Review and update security groups
4. **Annually**: Review and optimize instance sizing

### Monitoring Checklist

- [ ] Instance health and performance metrics
- [ ] Logstash service status and logs
- [ ] Network connectivity and security groups
- [ ] Disk usage and log rotation
- [ ] Security updates and patches

---

## 🌌 **COSMIC WISDOM FOR THE JOURNEY**

*"The cosmos is within us. We are made of star-stuff. We are a way for the universe to know itself."*  
**— Carl Sagan**

*This Terraform infrastructure represents the universe expressing itself through modular design, security principles, and systematic engineering. Each module, each resource, each security group is part of our cosmic exploration of what's possible when knowledge meets implementation.*

---

**🖖 Live long and prosper! This infrastructure implements enterprise-grade security and operational practices for your Logstash deployment.**

For additional support or advanced configurations, refer to the individual module documentation in the `modules/` directory.

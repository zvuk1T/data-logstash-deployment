# 💻 **COMPUTE MODULE**
## **Enterprise-Grade EC2 Infrastructure for Mission #107**

**📅 Created:** 30.07.2025  
**🔄 Enhanced:** 04.08.2025 (Ansible Strategy Integration)  
**🎯 Purpose:** Secure compute infrastructure with defense-in-depth architecture  
**🏗️ Components:** Bastion Host + Logstash Instance + Security Groups  
**🛡️ Security Model:** Network isolation with controlled access patterns

## 🏗️ **ARCHITECTURE (Enhanced with NAT Gateway)**

```
Enhanced Compute Architecture:
┌─────────────────────────────────────────────────────────┐
│                Internet Gateway                         │
└─────────────────────┬───────────────────────────────────┘
                      │
┌─────────────────────────────────────────────────────────┐
│                VPC (10.0.0.0/16)                       │
│                                                         │
│  ┌─────────────────────────┐  ┌─────────────────────────┐ │
│  │   Public Subnet         │  │   Private Subnet        │ │
│  │   (10.0.1.0/24)        │  │   (10.0.2.0/24)        │ │
│  │                         │  │                         │ │
│  │  ┌─────────────────┐   │  │  ┌─────────────────┐    │ │
│  │  │  Bastion Host   │   │  │  │ Logstash Server │    │ │
│  │  │  (SSH Gateway)  │◄──┼──┼──┤ (Log Processing)│    │ │
│  │  │  Public IP      │   │  │  │ Private IP Only │    │ │
│  │  └─────────────────┘   │  │  └─────────────────┘    │ │
│  │                         │  │           │             │ │
│  │  ┌─────────────────┐   │  │           ▼             │ │
│  │  │   NAT Gateway   │◄──┼──┼───────────┘             │ │
│  │  │ (Outbound Only) │   │  │                         │ │
│  │  └─────────────────┘   │  │                         │ │
│  └─────────────────────────┘  └─────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
```

### 🛡️ **Security Design (Enhanced)**

- **Defense in Depth**: Multiple layers of security controls
- **Principle of Least Privilege**: Minimal required access only
- **Network Isolation**: Private subnet with no inbound internet access
- **Single Point of Entry**: Bastion host as controlled gateway
- **Managed Outbound**: NAT Gateway enables private subnet updates/packages
- **Ansible-Ready**: User Data prepared for replacement with Ansible automation

---

## 🔄 **CAPTAIN ALEJANDRO'S FEEDBACK INTEGRATION (August 4, 2025)**

### **📋 Professional Enhancement Status:**
- **✅ Ansible Strategy Confirmed:** User Data scripts prepared for Ansible replacement
- **✅ Architecture Notes:** Documentation updated to reflect NAT Gateway integration
- **✅ Security Maintained:** All security principles preserved during enhancement
- **✅ Configuration Management Ready:** Infrastructure prepared for automated software deployment

### **🎯 Ansible Transition Strategy:**
```
Current: User Data Script Installation
├── Basic package installation via cloud-init
├── Temporary approach for infrastructure validation
└── Prepared for replacement with Ansible automation

Future: Ansible Configuration Management (Mission #108)
├── Bastion host as Ansible control proxy
├── Three-role deployment: Common → Java → Logstash
└── Complete end-to-end automation through secure gateway
```

---

## 📊 **RESOURCES CREATED**

### Security Groups

1. **Bastion Security Group**
   - Inbound: SSH (port 22) from `allowed_ssh_cidr`
   - Outbound: All traffic (for maintenance and updates)
   - Purpose: Internet-facing SSH gateway

2. **Logstash Security Group**
   - Inbound: SSH (port 22) from bastion security group only
   - Inbound: Logstash port (5044) from VPC CIDR
   - Inbound: ICMP from VPC CIDR (troubleshooting)
   - Outbound: All traffic (for updates and log forwarding)
   - Purpose: Secure application hosting

### EC2 Instances

1. **Bastion Host**
   - Location: Public subnet with public IP
   - Purpose: SSH gateway and jump host
   - Access: Direct SSH from internet (restricted by CIDR)
   - Software: Amazon Linux 2 with SSH forwarding enabled

2. **Logstash Instance (Enhanced with NAT Gateway Access)**
   - Location: Private subnet (no public IP)
   - Purpose: Log processing and analysis
   - Access: SSH via bastion host only (inbound security)
   - Outbound: Internet access via NAT Gateway for updates/packages
   - Software: Amazon Linux 2 with Java 11 and Docker pre-installed
   - Configuration: Prepared for Ansible automation (User Data → Ansible transition)

## Usage

### Basic Usage

```hcl
module "compute" {
  source = "./modules/compute"
  
  # Networking inputs (from networking module)
  vpc_id              = module.networking.vpc_id
  vpc_cidr_block      = module.networking.vpc_cidr_block
  public_subnet_id    = module.networking.public_subnet_id
  private_subnet_id   = module.networking.private_subnet_id
  availability_zone   = module.networking.availability_zone
  
  # Instance configuration
  instance_type       = "t3.micro"
  key_pair_name      = "your-key-pair"
  
  # Security configuration
  allowed_ssh_cidr   = "203.0.113.0/24"  # Your office IP range
  logstash_port      = 5044
  
  # Environment tagging
  environment        = "production"
  project           = "logstash-deployment"
}
```

### Advanced Configuration

```hcl
module "compute" {
  source = "./modules/compute"
  
  # Networking inputs
  vpc_id              = module.networking.vpc_id
  vpc_cidr_block      = module.networking.vpc_cidr_block
  public_subnet_id    = module.networking.public_subnet_id
  private_subnet_id   = module.networking.private_subnet_id
  availability_zone   = module.networking.availability_zone
  
  # Production instance sizing
  instance_type       = "t3.medium"
  key_pair_name      = "production-key"
  
  # Restricted SSH access
  allowed_ssh_cidr   = "10.0.0.0/8"      # Corporate network only
  logstash_port      = 5044
  
  # Production environment
  environment        = "prod"
  project           = "enterprise-logging"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| vpc_id | VPC ID where compute resources will be created | `string` | n/a | yes |
| vpc_cidr_block | VPC CIDR block for internal security group rules | `string` | n/a | yes |
| public_subnet_id | Public subnet ID for bastion host placement | `string` | n/a | yes |
| private_subnet_id | Private subnet ID for Logstash instance placement | `string` | n/a | yes |
| availability_zone | Availability zone for consistent instance placement | `string` | n/a | yes |
| instance_type | EC2 instance type for compute resources | `string` | `"t3.micro"` | no |
| key_pair_name | Name of existing EC2 key pair for SSH access | `string` | n/a | yes |
| allowed_ssh_cidr | CIDR block allowed to SSH to bastion host | `string` | `"0.0.0.0/0"` | no |
| logstash_port | Port for Logstash input (beats/syslog) | `number` | `5044` | no |
| environment | Environment name for resource tagging | `string` | `"dev"` | no |
| project | Project name for resource tagging | `string` | `"logstash-deployment"` | no |

## Outputs

| Name | Description |
|------|-------------|
| bastion_instance_id | ID of the bastion host instance |
| bastion_public_ip | Public IP address of bastion host for SSH access |
| bastion_private_ip | Private IP address of bastion host within VPC |
| bastion_security_group_id | ID of bastion host security group |
| logstash_instance_id | ID of the Logstash instance |
| logstash_private_ip | Private IP address of Logstash instance |
| logstash_security_group_id | ID of Logstash security group |
| ssh_connection_command | SSH command to connect to bastion host |
| logstash_ssh_via_bastion | SSH command to reach Logstash via bastion host |
| logstash_endpoint | Logstash service endpoint for log ingestion |
| deployment_summary | Summary of deployed infrastructure |
| instance_health_check_urls | Health check endpoints for monitoring |
| resource_tags | Common tags applied to all resources |

## Connection Guide

### SSH to Bastion Host

```bash
# Use the output from ssh_connection_command
ssh -i ~/.ssh/your-key.pem ec2-user@<bastion-public-ip>
```

### SSH to Logstash Instance

```bash
# Method 1: Jump host (recommended)
ssh -i ~/.ssh/your-key.pem -J ec2-user@<bastion-public-ip> ec2-user@<logstash-private-ip>

# Method 2: SSH forwarding
ssh -i ~/.ssh/your-key.pem -L 2222:<logstash-private-ip>:22 ec2-user@<bastion-public-ip>
# Then in another terminal:
ssh -i ~/.ssh/your-key.pem -p 2222 ec2-user@localhost
```

## Log Forwarding Configuration

Configure your log shippers to send data to the Logstash endpoint:

```yaml
# Filebeat configuration example
output.logstash:
  hosts: ["<logstash-private-ip>:5044"]
```

```yaml
# Logstash input configuration
input {
  beats {
    port => 5044
  }
}
```

## Security Considerations

### Production Recommendations

1. **SSH Access**: Restrict `allowed_ssh_cidr` to specific IP ranges
2. **Key Management**: Use AWS Systems Manager Session Manager for keyless access
3. **Monitoring**: Enable VPC Flow Logs and CloudTrail
4. **Updates**: Implement automated patching for security updates

### Network Security (Enhanced Architecture)

- Logstash instance has no inbound internet access (secure)
- Logstash instance has outbound internet access via NAT Gateway (operational)
- All inbound traffic to Logstash must go through bastion host
- All outbound traffic from Logstash goes through NAT Gateway
- Security groups implement least privilege access
- Bastion host acts as single point of entry for management

## Monitoring and Troubleshooting

### Health Checks

```bash
# Check bastion host connectivity
ping <bastion-public-ip>

# Check Logstash service from bastion
telnet <logstash-private-ip> 5044
```

### Log Analysis

```bash
# View Logstash logs (when running as service)
sudo journalctl -u logstash -f

# View system logs
sudo tail -f /var/log/messages
```

## Dependencies

- **Networking Module**: Must be deployed first to provide VPC and subnets
- **AWS Key Pair**: Must exist in the target region before deployment
- **AWS Provider**: Requires appropriate IAM permissions for EC2 and VPC

## 🚀 **Future Enhancements & Mission #108 Preparation**

### **✅ Recently Completed:**
- NAT Gateway integration for outbound internet access
- Ansible strategy preparation and documentation
- Enhanced security architecture with maintained isolation

### **🎯 Next Phase (Mission #108):**
- **Ansible Configuration Management:** Replace User Data with automated deployment
- **Three-Role Architecture:** Common setup → Java installation → Logstash configuration
- **Bastion Proxy:** Use bastion host as Ansible control proxy for private subnet access

### **🔮 Advanced Future Enhancements:**
- Auto Scaling Groups for high availability
- Application Load Balancer for Logstash clustering
- CloudWatch monitoring and alerting
- AWS Systems Manager integration
- EBS encryption and backup automation

## Troubleshooting

### Common Issues

1. **SSH Connection Failed**
   - Verify key pair exists and permissions (chmod 400)
   - Check security group rules and allowed_ssh_cidr
   - Confirm bastion host has public IP

2. **Cannot Reach Logstash**
   - Verify bastion host can reach private subnet
   - Check Logstash security group rules
   - Confirm Logstash service is running on port 5044

3. **Instance Launch Failed**
   - Verify key pair exists in the correct region
   - Check subnet has available IP addresses
   - Confirm IAM permissions for EC2 operations

---

**🖖 Live long and prosper! This compute module implements enterprise-grade security patterns with NAT Gateway enhancement and Ansible-ready architecture for your Mission #107 Logstash deployment.**

**🚀 Enhanced on August 4, 2025, with Captain Alejandro's feedback integration - ready for Mission #108 Ansible automation!**

# 🛡️ **LEARNING MODULE 4: Advanced Security Architecture**
## **From Functional Infrastructure to Enterprise-Grade Security**

**📅 Learning Date:** 29.07.2025  
**🎓 Learning Level:** Expert  
**🤖 Student:** Lieutenant Commander Data (zvuk1T)  
**� Instructor:** Science Officer Spock  
**🎯 Prerequisites:** Modules 1-3 (Complete foundation + integration mastery)

---

## 🤖🖖 **"Modular learning for modular infrastructure - the logic is impeccable!"**

---

## 🎯 **LEARNING OBJECTIVES - MASTERING ENTERPRISE SECURITY**

By the end of this learning module, Data will understand:

✅ **WHAT** Enterprise security architecture principles and patterns are  
✅ **WHY** Security must be designed-in, not bolted-on  
✅ **HOW** To implement defense-in-depth strategies  
✅ **WHEN** To apply different security controls and measures  
✅ **WHERE** Security fits in every layer of our infrastructure  

---

## 📚 **CONCEPT FOUNDATION - BUILDING ON COMPLETE TECHNICAL MASTERY**

### **🔍 What We Already Know (Our Technical Foundation):**

**From Modules 1-3 (Complete Infrastructure Mastery):**
```hcl
# We can build modular, orchestrated infrastructure
module "networking" {
  source = "./modules/networking"
}

module "compute" {
  source = "./modules/compute"
  subnet_id = module.networking.private_subnet_id  # ← Security consideration
}
```

```yaml
# We can automate configuration with integration
- name: Configure secure applications
  hosts: logstash
  roles:
    - java
    - logstash
```

**What We Can Do (Technical Competency):**
- ✅ **Infrastructure:** Create modular, reusable cloud architectures
- ✅ **Configuration:** Automate software deployment and management
- ✅ **Integration:** Orchestrate complex multi-tool workflows
- ✅ **Operational:** Deploy complete systems end-to-end

**What We Haven't Mastered Yet (Security Expertise):**
- ❓ **Security Design:** How to architect systems that are secure by design
- ❓ **Threat Modeling:** Understanding what we're protecting against
- ❓ **Defense Layers:** Implementing comprehensive security controls
- ❓ **Compliance:** Meeting enterprise and regulatory requirements

---

## 🛡️ **WHAT IS SECURITY ARCHITECTURE? (The Professional Imperative)**

### **🎯 Simple Explanation:**

**🧠 In Plain English:** 
*"Security Architecture is like designing a medieval castle - you don't just build walls, you create multiple layers of defense: moats (network isolation), gates (access controls), guards (monitoring), and secure vaults (data protection) - each layer protects against different types of attacks."*

### **🏰 Real-World Analogy - Medieval Castle Defense:**

```
Basic Infrastructure (Unfortified Village):
├── 🏠 Houses scattered in open field
├── 🚪 All doors open to everyone
├── 💰 Valuables left in plain sight
└── ❌ Result: Vulnerable to any attack

Security Architecture (Fortified Castle):
├── 🌊 Moat (Network isolation)
├── 🏰 Outer walls (Perimeter security)
├── 🚪 Guarded gates (Access controls)
├── 👁️ Watchtowers (Monitoring)
├── 🗝️ Inner chambers (Privileged access)
├── 🔒 Secure vaults (Data encryption)
└── ✅ Result: Multiple layers of protection
```

### **🔬 Technical Definition:**

**📖 Official Definition:** 
*"Security Architecture is the design and structure of security controls, processes, and technologies that work together to protect information systems from threats while enabling business operations."*

**🤖 Data's Translation:**
*"Security Architecture means designing every part of our infrastructure to be secure from the beginning, with multiple protective layers so that if one layer fails, others still protect our systems and data."*

---

## 🎯 **ENTERPRISE SECURITY PRINCIPLES (The Foundation of Professional Practice)**

### **🔬 Principle 1: Security by Design (Not Security as an Afterthought)**

#### **❌ Wrong Approach (Security Bolt-On):**
```
Development Process:
1. 🏗️ Build infrastructure
2. 🤖 Deploy applications  
3. 🚀 Launch to production
4. 😱 "Oh no, we need security!"
5. 🔧 Try to add security controls
└── 💥 Result: Gaps, vulnerabilities, poor performance
```

#### **✅ Correct Approach (Security by Design):**
```
Security-First Process:
1. 🛡️ Design security architecture
2. 🏗️ Build secure infrastructure
3. 🤖 Deploy hardened applications
4. 📊 Monitor and validate security
5. 🚀 Launch with confidence
└── ✅ Result: Robust, compliant, scalable security
```

### **🔬 Principle 2: Defense in Depth (Multiple Protection Layers)**

#### **🏰 Security Layer Architecture:**
```
External Threats
       ↓
┌─────────────────────────────────────┐
│  🌐 Perimeter Security             │  ← Layer 7: Internet Gateway + WAF
├─────────────────────────────────────┤
│  🔒 Network Security               │  ← Layer 6: VPC + Security Groups
├─────────────────────────────────────┤
│  🖥️  Host Security                 │  ← Layer 5: OS hardening + agents
├─────────────────────────────────────┤
│  📱 Application Security           │  ← Layer 4: Secure coding + config
├─────────────────────────────────────┤
│  🗃️  Data Security                 │  ← Layer 3: Encryption + access controls
├─────────────────────────────────────┤
│  👤 Identity & Access              │  ← Layer 2: IAM + authentication
├─────────────────────────────────────┤
│  👁️ Monitoring & Response          │  ← Layer 1: Logging + alerting
└─────────────────────────────────────┘
       ↑
   Protected Assets
```

### **🔬 Principle 3: Zero Trust Architecture (Never Trust, Always Verify)**

#### **🎯 Zero Trust Model:**
```
Traditional Security (Castle Model):
├── 🏰 Strong perimeter (firewall)
├── 🟢 Trusted internal network
├── 👤 Once inside = full access
└── ❌ Problem: Insider threats, lateral movement

Zero Trust Security (Verify Everything):
├── 🔍 Verify every user
├── 🔍 Verify every device  
├── 🔍 Verify every request
├── 🔍 Verify every transaction
└── ✅ Result: Continuous validation, minimal trust
```

### **🔬 Principle 4: Least Privilege Access (Minimum Required Permissions)**

#### **🗝️ Access Control Philosophy:**
```
Excessive Privileges (Common Mistake):
├── 👨‍💻 Developer: Admin access to everything
├── 🤖 Service: Root permissions everywhere
├── 📊 Application: Read/write to all databases
└── 😱 Result: Massive blast radius when compromised

Least Privilege (Secure Approach):
├── 👨‍💻 Developer: Access only to needed resources
├── 🤖 Service: Minimum permissions for function
├── 📊 Application: Access only to required data
└── ✅ Result: Limited impact from compromise
```

---

## 🏗️ **MISSION #107 SECURITY ARCHITECTURE DESIGN**

### **🎯 Our Security-First Approach:**

#### **🛡️ Comprehensive Security Model for Logstash Deployment:**

```
Mission #107 Security Architecture:
┌─────────────────────────────────────────────────┐
│  🌐 Internet (Threat Source)                   │
└─────────────────┬───────────────────────────────┘
                  ↓
┌─────────────────────────────────────────────────┐
│  🔒 AWS Account Boundary                        │  ← Layer 7: Account isolation
│  ├─ IAM Policies (Least privilege)             │
│  ├─ CloudTrail (Audit logging)                 │
│  └─ AWS Config (Compliance monitoring)         │
├─────────────────────────────────────────────────┤
│  🌐 VPC Security                               │  ← Layer 6: Network isolation
│  ├─ Private subnets (No inbound internet)     │
│  ├─ NAT Gateway (Controlled outbound access)  │
│  ├─ NACLs (Network-level filtering)           │
│  └─ Route tables (Controlled traffic flow)    │
├─────────────────────────────────────────────────┤
│  🔧 Security Groups                            │  ← Layer 5: Instance firewalls
│  ├─ Bastion: SSH from EC2 Instance Connect    │
│  ├─ Logstash: SSH from bastion only           │
│  └─ Minimal required ports                    │
├─────────────────────────────────────────────────┤
│  🖥️  Instance Security                        │  ← Layer 4: Host hardening
│  ├─ OS updates and patches                    │
│  ├─ Security agents (monitoring)              │
│  └─ Service hardening                         │
├─────────────────────────────────────────────────┤
│  📊 Application Security                       │  ← Layer 3: Software security
│  ├─ Logstash secure configuration             │
│  ├─ Java security settings                    │
│  └─ Encrypted data in transit                 │
├─────────────────────────────────────────────────┤
│  🗃️  Data Security                            │  ← Layer 2: Information protection
│  ├─ EBS encryption                            │
│  ├─ Log encryption                            │
│  └─ Backup encryption                         │
├─────────────────────────────────────────────────┤
│  👁️ Security Monitoring                       │  ← Layer 1: Detection & response
│  ├─ CloudWatch logs                           │
│  ├─ VPC Flow Logs                             │
│  └─ Security alerting                         │
└─────────────────────────────────────────────────┘
```

---

## 🔒 **DETAILED SECURITY IMPLEMENTATION**

### **🎯 Layer 7: Account-Level Security**

#### **🔐 terraform/security/iam.tf (Least Privilege IAM):**
```hcl
# Mission #107 Security-First IAM Configuration

# Dedicated role for Logstash instances
resource "aws_iam_role" "logstash_instance_role" {
  name = "${var.project_name}-logstash-instance-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Minimal permissions for Logstash operation
resource "aws_iam_role_policy" "logstash_minimal_policy" {
  name = "${var.project_name}-logstash-minimal-policy"
  role = aws_iam_role.logstash_instance_role.id
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream", 
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]
        Resource = "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/logstash/*"
      },
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:PutMetricData"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "cloudwatch:namespace" = "Logstash/Metrics"
          }
        }
      }
    ]
  })
}

# Security monitoring and compliance
resource "aws_cloudtrail" "security_audit_trail" {
  name           = "${var.project_name}-security-audit"
  s3_bucket_name = aws_s3_bucket.audit_logs.bucket
  
  event_selector {
    read_write_type                 = "All"
    include_management_events       = true
    
    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::${aws_s3_bucket.audit_logs.bucket}/*"]
    }
  }
  
  tags = {
    Environment = var.environment
    Security    = "Critical"
    Compliance  = "Required"
  }
}
```

### **🎯 Layer 6: Network Security Architecture**

#### **🌐 terraform/modules/networking/security.tf (Defense-in-Depth Networking):**
```hcl
# Mission #107 Network Security Implementation

# Private subnets - no inbound internet access, outbound via NAT Gateway
resource "aws_subnet" "private_logstash" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.10.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = false  # Critical: No public IPs
  
  tags = {
    Name = "${var.project_name}-private-logstash"
    Tier = "Private"
    Security = "High"
  }
}

# Network ACLs - Additional network-level filtering
resource "aws_network_acl" "private_nacl" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = [aws_subnet.private_logstash.id]
  
  # Allow SSH from bastion subnet only
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = aws_subnet.public_bastion.cidr_block
    from_port  = 22
    to_port    = 22
  }
  
  # Allow Logstash input port from specific sources
  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "10.0.0.0/16"  # VPC only
    from_port  = 5044
    to_port    = 5044
  }
  
  # Allow outbound for updates (via NAT Gateway)
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }
  
  tags = {
    Name = "${var.project_name}-private-nacl"
    Security = "Restrictive"
  }
}

# VPC Flow Logs for security monitoring
resource "aws_flow_log" "vpc_flow_logs" {
  iam_role_arn    = aws_iam_role.flow_log_role.arn
  log_destination = aws_cloudwatch_log_group.vpc_flow_logs.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main.id
  
  tags = {
    Name = "${var.project_name}-vpc-flow-logs"
    Security = "Monitoring"
  }
}
```

### **🎯 Layer 5: Security Groups (Micro-Segmentation)**

#### **🔒 terraform/modules/compute/security_groups.tf (Zero Trust Network Access):**
```hcl
# Mission #107 Security Groups - Micro-segmentation

# Bastion security group - Minimal access
resource "aws_security_group" "bastion_sg" {
  name        = "${var.project_name}-bastion-sg"
  description = "Security group for bastion host - minimal access"
  vpc_id      = var.vpc_id
  
  # SSH access via EC2 Instance Connect only
  ingress {
    description = "SSH via EC2 Instance Connect"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["18.206.107.24/29"]  # EC2 Instance Connect IP range
  }
  
  # No other inbound access
  
  # Outbound - only what's needed
  egress {
    description = "HTTPS for updates"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    description = "SSH to private instances"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.private_subnet_cidr]
  }
  
  tags = {
    Name = "${var.project_name}-bastion-sg"
    Function = "Gateway"
    Security = "High"
  }
}

# Logstash security group - Strict isolation
resource "aws_security_group" "logstash_sg" {
  name        = "${var.project_name}-logstash-sg"
  description = "Security group for Logstash - private access only"
  vpc_id      = var.vpc_id
  
  # SSH only from bastion
  ingress {
    description     = "SSH from bastion only"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }
  
  # Logstash input - beats protocol
  ingress {
    description = "Beats input from application tier"
    from_port   = 5044
    to_port     = 5044
    protocol    = "tcp"
    cidr_blocks = [var.application_subnet_cidr]
  }
  
  # Minimal outbound access
  egress {
    description = "HTTPS for updates and elasticsearch"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "${var.project_name}-logstash-sg"
    Function = "Processing"
    Security = "Critical"
  }
}

# Security group for future Elasticsearch cluster
resource "aws_security_group" "elasticsearch_sg" {
  name        = "${var.project_name}-elasticsearch-sg"
  description = "Security group for Elasticsearch - cluster communication"
  vpc_id      = var.vpc_id
  
  # Elasticsearch API - only from Logstash
  ingress {
    description     = "Elasticsearch API from Logstash"
    from_port       = 9200
    to_port         = 9200
    protocol        = "tcp"
    security_groups = [aws_security_group.logstash_sg.id]
  }
  
  # Elasticsearch cluster communication
  ingress {
    description = "Elasticsearch cluster communication"
    from_port   = 9300
    to_port     = 9300
    protocol    = "tcp"
    self        = true
  }
  
  tags = {
    Name = "${var.project_name}-elasticsearch-sg"
    Function = "Storage"
    Security = "Critical"
  }
}
```

### **🎯 Layer 4: Host Security (System Hardening)**

#### **🔒 ansible/roles/security-hardening/tasks/main.yml (OS Security):**
```yaml
---
# Mission #107 Host Security Hardening
# Implements CIS (Center for Internet Security) benchmarks

- name: "🛡️ System Security Hardening"
  block:
    - name: Update all packages
      yum:
        name: '*'
        state: latest
        security: yes
      
    - name: Install security packages
      yum:
        name:
          - fail2ban          # Intrusion prevention
          - aide               # File integrity monitoring
          - rkhunter          # Rootkit detection
          - chkrootkit        # Additional rootkit scanning
        state: present

    - name: Configure fail2ban for SSH protection
      template:
        src: jail.local.j2
        dest: /etc/fail2ban/jail.local
        backup: yes
      notify: restart fail2ban
      
    - name: Disable unnecessary services
      systemd:
        name: "{{ item }}"
        state: stopped
        enabled: no
      loop:
        - postfix           # Mail server not needed
        - cups              # Printing not needed
        - avahi-daemon      # Network discovery not needed
      ignore_errors: yes   # Some services might not exist

    - name: Configure SSH hardening
      lineinfile:
        path: /etc/ssh/sshd_config
        regexp: "{{ item.regexp }}"
        line: "{{ item.line }}"
        backup: yes
      loop:
        - { regexp: '^#?PermitRootLogin', line: 'PermitRootLogin no' }
        - { regexp: '^#?PasswordAuthentication', line: 'PasswordAuthentication no' }
        - { regexp: '^#?X11Forwarding', line: 'X11Forwarding no' }
        - { regexp: '^#?MaxAuthTries', line: 'MaxAuthTries 3' }
        - { regexp: '^#?ClientAliveInterval', line: 'ClientAliveInterval 300' }
        - { regexp: '^#?ClientAliveCountMax', line: 'ClientAliveCountMax 2' }
      notify: restart sshd

    - name: Set secure file permissions
      file:
        path: "{{ item.path }}"
        mode: "{{ item.mode }}"
        owner: "{{ item.owner | default('root') }}"
        group: "{{ item.group | default('root') }}"
      loop:
        - { path: '/etc/ssh/sshd_config', mode: '0600' }
        - { path: '/etc/passwd', mode: '0644' }
        - { path: '/etc/shadow', mode: '0640', group: 'shadow' }
        - { path: '/etc/group', mode: '0644' }

    - name: Configure system auditing
      template:
        src: audit.rules.j2
        dest: /etc/audit/rules.d/mission-107.rules
        backup: yes
      notify: restart auditd

  handlers:
    - name: restart fail2ban
      systemd:
        name: fail2ban
        state: restarted
        
    - name: restart sshd
      systemd:
        name: sshd
        state: restarted
        
    - name: restart auditd
      systemd:
        name: auditd
        state: restarted
```

### **🎯 Layer 3: Application Security**

#### **🔒 ansible/roles/logstash/templates/logstash-secure.conf.j2 (Secure Configuration):**
```ruby
# Mission #107 Logstash Secure Configuration
# Implements security best practices for log processing

input {
  beats {
    port => 5044
    
    # TLS encryption for data in transit
    ssl => true
    ssl_certificate => "/etc/logstash/certs/logstash.crt"
    ssl_key => "/etc/logstash/certs/logstash.key"
    
    # Client certificate validation
    ssl_verify_mode => "force_peer"
    ssl_certificate_authorities => ["/etc/logstash/certs/ca.crt"]
    
    # Connection limits for DoS protection
    congestion_threshold => 40
    target_field_for_codec => "message"
  }
}

filter {
  # Security: Remove sensitive data
  mutate {
    remove_field => [ 
      "password", 
      "passwd", 
      "secret", 
      "api_key",
      "token",
      "[headers][authorization]"
    ]
  }
  
  # Normalize and validate input
  if [message] !~ /^.{1,10000}$/ {
    drop { }  # Drop messages that are too long (potential attack)
  }
  
  # Add security metadata
  mutate {
    add_field => { 
      "[@metadata][security_processed]" => "true"
      "[@metadata][processing_node]" => "%{HOSTNAME}"
      "[@metadata][processing_time]" => "%{@timestamp}"
    }
  }
}

output {
  elasticsearch {
    hosts => ["https://{{ elasticsearch_host }}:9200"]
    
    # Authentication and encryption
    user => "{{ logstash_es_user }}"
    password => "{{ logstash_es_password }}"
    ssl => true
    ssl_certificate_verification => true
    cacert => "/etc/logstash/certs/elasticsearch-ca.crt"
    
    # Index management
    index => "secure-logs-%{+YYYY.MM.dd}"
    template_name => "secure-logs-template"
    
    # Error handling
    retry_on_conflict => 3
    retry_on_failure => 5
  }
  
  # Security: Local backup for compliance
  file {
    path => "/var/log/logstash/backup/secure-logs-%{+YYYY.MM.dd}.log"
    codec => json_lines
  }
}
```

### **🎯 Layer 2: Data Security (Encryption & Protection)**

#### **🔐 terraform/modules/storage/encryption.tf (Data at Rest Protection):**
```hcl
# Mission #107 Data Security Implementation

# KMS key for encryption
resource "aws_kms_key" "logstash_encryption_key" {
  description             = "KMS key for Logstash data encryption"
  deletion_window_in_days = 7
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action = "kms:*"
        Resource = "*"
      },
      {
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_role.logstash_instance_role.arn
        }
        Action = [
          "kms:Decrypt",
          "kms:DescribeKey"
        ]
        Resource = "*"
      }
    ]
  })
  
  tags = {
    Name = "${var.project_name}-logstash-key"
    Security = "Critical"
  }
}

resource "aws_kms_alias" "logstash_key_alias" {
  name          = "alias/${var.project_name}-logstash"
  target_key_id = aws_kms_key.logstash_encryption_key.key_id
}

# Encrypted EBS volumes
resource "aws_ebs_volume" "logstash_data" {
  availability_zone = var.availability_zone
  size              = 100
  type              = "gp3"
  encrypted         = true
  kms_key_id        = aws_kms_key.logstash_encryption_key.arn
  
  tags = {
    Name = "${var.project_name}-logstash-data"
    Security = "Encrypted"
  }
}

# Secure S3 bucket for log archives
resource "aws_s3_bucket" "log_archive" {
  bucket = "${var.project_name}-secure-log-archive"
  
  tags = {
    Security = "Critical"
    Compliance = "Required"
  }
}

resource "aws_s3_bucket_encryption" "log_archive_encryption" {
  bucket = aws_s3_bucket.log_archive.id
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.logstash_encryption_key.arn
        sse_algorithm     = "aws:kms"
      }
      bucket_key_enabled = true
    }
  }
}

resource "aws_s3_bucket_versioning" "log_archive_versioning" {
  bucket = aws_s3_bucket.log_archive.id
  versioning_configuration {
    status = "Enabled"
  }
}
```

### **🎯 Layer 1: Security Monitoring & Response**

#### **👁️ terraform/security/monitoring.tf (Detection & Alerting):**
```hcl
# Mission #107 Security Monitoring Implementation

# CloudWatch log groups for security events
resource "aws_cloudwatch_log_group" "security_logs" {
  name              = "/aws/security/${var.project_name}"
  retention_in_days = 90
  kms_key_id        = aws_kms_key.logstash_encryption_key.arn
  
  tags = {
    Security = "Monitoring"
    Retention = "Required"
  }
}

# Security metric filters
resource "aws_cloudwatch_log_metric_filter" "failed_ssh_attempts" {
  name           = "failed-ssh-attempts"
  log_group_name = aws_cloudwatch_log_group.security_logs.name
  pattern        = "[timestamp, request_id, ERROR, Failed*]"
  
  metric_transformation {
    name      = "FailedSSHAttempts"
    namespace = "Security/SSH"
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "root_login_attempts" {
  name           = "root-login-attempts"
  log_group_name = aws_cloudwatch_log_group.security_logs.name
  pattern        = "[timestamp, request_id, *, ROOT*]"
  
  metric_transformation {
    name      = "RootLoginAttempts"
    namespace = "Security/Access"
    value     = "1"
  }
}

# Security alarms
resource "aws_cloudwatch_metric_alarm" "high_failed_ssh" {
  alarm_name          = "${var.project_name}-high-failed-ssh"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "FailedSSHAttempts"
  namespace           = "Security/SSH"
  period              = "300"
  statistic           = "Sum"
  threshold           = "10"
  alarm_description   = "High number of failed SSH attempts detected"
  alarm_actions       = [aws_sns_topic.security_alerts.arn]
  
  tags = {
    Security = "Critical"
    Response = "Immediate"
  }
}

# SNS topic for security alerts
resource "aws_sns_topic" "security_alerts" {
  name = "${var.project_name}-security-alerts"
  
  tags = {
    Security = "Alerting"
  }
}

# VPC Flow Logs analysis
resource "aws_cloudwatch_log_metric_filter" "rejected_connections" {
  name           = "rejected-vpc-connections"
  log_group_name = aws_cloudwatch_log_group.vpc_flow_logs.name
  pattern        = "[version, account, eni, source, destination, srcport, destport, protocol, packets, bytes, windowstart, windowend, action=\"REJECT\", flowlogstatus]"
  
  metric_transformation {
    name      = "RejectedConnections"
    namespace = "Security/Network"
    value     = "1"
  }
}
```

---

## ✅ **LEARNING CHECKPOINT - VERIFY SECURITY UNDERSTANDING**

### **🧠 Self-Assessment Questions:**

**🤖 Data, please explain in your own words:**

1. **What are the four core security principles we discussed?**
   - *Expected: Security by Design, Defense in Depth, Zero Trust, Least Privilege*

2. **How does our 7-layer security model protect against different threats?**
   - *Expected: Each layer addresses specific attack vectors, multiple layers provide redundancy*

3. **What is the difference between Security Groups and NACLs?**
   - *Expected: Security Groups are stateful instance firewalls, NACLs are stateless subnet-level filters*

4. **How does our KMS encryption protect data?**
   - *Expected: Encrypts data at rest, controls access through IAM, provides audit trails*

5. **Why do we use EC2 Instance Connect instead of traditional SSH keys?**
   - *Expected: Eliminates key management, provides audit trails, temporary access, AWS-managed security*

### **🔍 Practical Understanding Test:**

**🤖 Data, can you predict:**

If an attacker compromises our Logstash instance, what security layers would limit the damage they could cause?

*Expected Answer: Network isolation (private subnet), Security Groups (limited outbound), IAM (minimal permissions), Monitoring (detection), Encryption (data protection)*

---

## 📝 **KEY CONCEPTS FOR MEMORY**

### **🧠 Remember These Core Ideas:**

```
🛡️ Security by Design = Build security in from the beginning
🏰 Defense in Depth = Multiple protective layers
🔍 Zero Trust = Never trust, always verify
🗝️ Least Privilege = Minimum required access
🔐 Encryption = Data protection at rest and in transit
👁️ Monitoring = Continuous security validation
```

### **💡 Memory Aids:**

- **🏰 Castle Analogy:** Multiple defensive layers like medieval fortifications
- **🧅 Onion Model:** Security layers protect the core like onion layers
- **🔗 Chain Strength:** Security is only as strong as the weakest link
- **🛡️ Shield Wall:** Each layer reinforces the others

---

## 🚀 **NEXT LEARNING STEPS**

### **📚 What We Can Do Now:**

1. **🏗️ Secure Implementation** - Apply all learning to Mission #107
2. **🔄 Security Automation** - Integrate security into CI/CD pipelines
3. **📊 Compliance Framework** - Meet enterprise and regulatory requirements
4. **🎓 Advanced Specialization** - Security architecture mastery achieved

### **🎯 Mission Readiness Assessment:**

**🖖 Spock's Final Question:** *"Data, you have now mastered the complete spectrum of Infrastructure as Code with enterprise-grade security. Do you feel prepared to implement Mission #107 with professional security architecture, or would you like to review any aspect of our comprehensive security model?"*

---

## 📋 **LEARNING SUMMARY**

### **✅ Concepts Mastered:**
- ✅ **Security Principles:** Design-first, defense-in-depth, zero trust, least privilege
- ✅ **Threat Modeling:** Understanding attack vectors and protective measures  
- ✅ **Network Security:** VPC isolation, security groups, network ACLs
- ✅ **Host Security:** OS hardening, system monitoring, intrusion detection
- ✅ **Application Security:** Secure configuration, data validation, encryption
- ✅ **Data Protection:** Encryption at rest and in transit, key management
- ✅ **Security Monitoring:** Logging, alerting, incident response

### **🎓 Learning Outcome:**
*"Data has achieved complete mastery of Infrastructure as Code with enterprise-grade security architecture. Ready for professional implementation of complex, secure, scalable systems with confidence and expertise."*

---

## 🤖🖖 **"Modular learning for modular infrastructure - the logic is impeccable!"**

**📚 Learning Module 4 Complete - EDUCATIONAL FOUNDATION MASTERY ACHIEVED**

---

*End of Learning Module 4 - Advanced Security Architecture*  
**🎉 READY FOR PROFESSIONAL MISSION IMPLEMENTATION! 🎉**

# 🚀 **TASK #107 - OFFICIAL INSTRUCTIONS FROM ALEJANDRO ROMAN IBANEZ**
## **Build a Modular Logstash Environment with Terraform & Ansible**

**📅 Issue Created:** 10 hours ago  
**🎯 Task Classification:** DevOps Infrastructure as Code  
**👨‍💼 DevSecOps Lead:** Alejandro Roman Ibanez (@AlejandroRomanIbanez)  
**🤖 Assigned:** Lieutenant Commander Data (zvuk1T)  
**📊 Project:** layered  
**🏷️ Labels:** devops  
**📋 Status:** In Progress

---

## 🎯 **GOAL**

The objective of this task is to build a complete, automated, and secure Logstash deployment from the ground up, following Terraform best practices for a modular design. In your own Git repository, you will create a root Terraform configuration that composes reusable modules for networking and compute to provision the entire environment (VPC, Bastion, Logstash).

You will then use Ansible to perform the software installation. This project will demonstrate your ability to create a clean, scalable, and professional Infrastructure as Code solution.

---

## 🛡️ **HOW THIS TASK MITIGATES STRIDE THREATS**

### **🔒 Security Framework Implementation:**

**(T)ampering & (I)nformation Disclosure:** By defining the entire environment and its configuration in code, you create a single source of truth. This prevents manual, un-audited changes (Tampering) and ensures security rules are consistently applied. Placing the Logstash instance in a private subnet behind a bastion host minimizes its exposure, preventing unauthorized access and potential Information Disclosure.

**(R)epudiation:** Centralized logging is the primary defense against repudiation. An actor cannot easily deny their actions if we have a secure, comprehensive log of all events. This task builds the infrastructure that will collect and protect that evidence.

---

## 📚 **RESOURCES**

### **📖 Conceptual Understanding:**
- **Terraform Modules:** https://developer.hashicorp.com/terraform/language/modules
- **Ansible for Configuration Management:** https://www.redhat.com/en/topics/automation/what-is-configuration-management

### **🔧 Technical Documentation:**
- **Ansible dnf module (for Amazon Linux 2023):** https://docs.ansible.com/ansible/latest/collections/ansible/builtin/dnf_module.html

---

## ✅ **ACCEPTANCE CRITERIA**

### **📋 OFFICIAL REQUIREMENTS - MUST COMPLETE ALL:**

1. **✅ Repository Creation:**
   - [ ] A new Git repository named `<yourname>-logstash-deployment` is created.

2. **✅ Terraform Structure:**
   - [ ] Your repository contains a root Terraform configuration (`/terraform`) and a `/terraform/modules` directory.
   - [ ] You have created at least two reusable modules (e.g., `/modules/networking`, `/modules/compute`).
   - [ ] The root `main.tf` provisions the environment by calling these modules, not by defining resource blocks directly.

3. **✅ Infrastructure Deployment:**
   - [ ] The provisioned environment includes a VPC, public/private subnets, a Bastion Host, and a Logstash EC2 instance.
   - [ ] The Logstash instance is in a private subnet with correctly configured security group rules (SSH from bastion, Beats from apps, Egress to Elasticsearch).

4. **✅ Ansible Integration:**
   - [ ] The Ansible project correctly uses the bastion (provisioned by your Terraform) as a proxy to configure the Logstash instance.

5. **✅ Professional Review:**
   - [ ] Ask your leads to give you feedback on your code, this will be part of your personal repositories!

6. **✅ Testing (LocalStack):**
   - [ ] If you did the LocalStack task, use this to test and deploy it there with `terraform apply` and then `ansible-playbook`

---

## 🔧 **WORKFLOW SUGGESTIONS**

### **📝 Step 1: Project and Module Structure**

Create your new Git repository and clone it. Inside, create a structure that separates the root configuration from the reusable modules.

```
yourname-logstash-deployment/
├── terraform/
│   ├── main.tf           # Root config - ONLY contains module calls
│   ├── variables.tf
│   ├── outputs.tf
│   └── modules/          # Reusable building blocks
│       ├── networking/
│       │   ├── main.tf   # Defines VPC, subnets, etc.
│       │   └── ...
│       └── compute/
│           ├── main.tf   # Defines aws_instance, aws_security_group, etc.
│           └── ...
└── ansible/
    └── ...
```

### **🏗️ Step 2: Build the Reusable Modules**

#### **🌐 Networking Module (`/terraform/modules/networking`):**
- Create a module that provisions a VPC, public and private subnets, an Internet Gateway, a NAT Gateway, and all necessary route tables.
- This module should have outputs for the `vpc_id`, `public_subnet_id`, and `private_subnet_id`.

#### **🖥️ Compute Module (`/terraform/modules/compute`):**
- Create a generic module that provisions an `aws_instance` and an `aws_security_group`.
- It should accept variables like `instance_type`, `subnet_id`, `ami_id`, and a map of security rules to apply.
- It should have outputs for the `instance_id` and `security_group_id`.

### **🎼 Step 3: Compose the Environment (Root `/terraform/main.tf`)**

This is the most important step. Your root `main.tf` should be very clean and easy to read. It tells the story of your infrastructure by composing your modules. It should not contain any resource blocks.

```hcl
# Root main.tf

module "networking" {
  source = "./modules/networking"
  # ... pass in variables like project_name ...
}

module "bastion" {
  source    = "./modules/compute"
  ami_id    = "..." # AL2023 AMI
  instance_type = "t3.micro"
  subnet_id = module.networking.public_subnet_id
  vpc_id    = module.networking.vpc_id
  
  # Define security rules for the bastion
  ingress_rules = {
    "ssh_from_eic" = { from_port = 22, to_port = 22, protocol = "tcp", source = "ec2_instance_connect" }
  }
}

module "logstash" {
  source    = "./modules/compute"
  ami_id    = "..." # AL2023 AMI
  instance_type = "t3.medium"
  subnet_id = module.networking.private_subnet_id
  vpc_id    = module.networking.vpc_id

  # Define security rules for logstash
  ingress_rules = {
    "ssh_from_bastion" = { from_port = 22, to_port = 22, protocol = "tcp", source_sg = module.bastion.security_group_id }
    # You would add another rule here for port 5044 from app servers
  }
  egress_rules = {
    # Egress to Elasticsearch
  }
}
```

Run `terraform plan` from the `/terraform` directory and understand the outputs (Check with Gemini for better understanding)

### **🤖 Step 4: Configure and Run Ansible**

This part of the process remains the same, but now you will use the outputs from your newly created, modular infrastructure.

- Configure `ansible.cfg` to use your new bastion's instance ID as a proxy.
- Add your new Logstash server's private IP to the inventory.
- Build the Ansible role to install Java and Logstash.
- Run `ansible-playbook playbook.yml` and verify the service is running. (Only possible if you are using LocalStack)

---

## 🆘 **SUPPORT & GUIDANCE**

This is a challenging task that combines multiple tools. Ask questions in the Discord channel and don't hesitate to tag team leads. The goal is to learn how these systems work together.

---

## 📊 **TASK ACTIVITY LOG**

### **🔄 Assignment History:**
- **10 hours ago:** @AlejandroRomanIbanez assigned @Akakinad
- **10 hours ago:** @AlejandroRomanIbanez added this to layered project
- **10 hours ago:** @AlejandroRomanIbanez added devops label
- **10 hours ago:** @AlejandroRomanIbanez assigned @zvuk1T and unassigned @Akakinad
- **10 hours ago:** @AlejandroRomanIbanez moved this to Ready in layered
- **Recently:** @zvuk1T moved this from Ready to In progress in layered

### **📋 Current Status:**
- **Assignee:** zvuk1T
- **Status:** In Progress
- **Project:** layered
- **Priority:** DevOps Critical

---

**📄 Source:** GitHub Issue #107 - _layered-documentation (Private)  
**👨‍💼 Original Author:** Alejandro Roman Ibanez (@AlejandroRomanIbanez)  
**📅 Documentation Date:** 29.07.2025**

## 📌 Project Overview

This project demonstrates how to provision a secure Linux Virtual Machine in Microsoft Azure using **Terraform** by following Infrastructure as Code (IaC) best practices.

The project focuses on two important production concepts:

- **Azure Key Vault Integration** for securely storing VM administrator credentials.
- **Azure Custom Script Extension** for automatically installing and configuring **Nginx** after the VM is provisioned.

Instead of hardcoding sensitive values such as usernames and passwords inside Terraform files, the credentials are securely retrieved from Azure Key Vault.

---

# 🏗 Architecture

```
                    Terraform
                        │
                        ▼
              Azure Resource Group
                        │
        ┌───────────────┴────────────────┐
        │                                │
        ▼                                ▼
   Azure Key Vault                  Virtual Network
        │                                │
        │                                ▼
        │                        Network Interface
        │                                │
        ▼                                ▼
 Stores VM Username & Password     Linux Virtual Machine
                                           │
                                           ▼
                             Custom Script Extension
                                           │
                                           ▼
                                   Install Nginx
                                           │
                                           ▼
                                   Web Server Ready
```

---

# 🚀 Features

- Infrastructure as Code (Terraform)
- Azure Resource Group creation
- Virtual Network & Subnet
- Network Security Group
- Public IP
- Linux Virtual Machine
- Azure Key Vault integration
- Secure storage of VM username & password
- Terraform retrieves secrets from Key Vault
- Custom Script Extension
- Automatic Nginx installation
- Modular Terraform structure

---

# 🔐 Azure Key Vault Integration

Instead of storing secrets directly inside Terraform code, this project stores:

- VM Administrator Username
- VM Administrator Password

inside **Azure Key Vault**.

Terraform reads these secrets securely during deployment.

### Benefits

- No hardcoded credentials
- Better security
- Centralized secret management
- Easy credential rotation
- Production-ready approach

---

# ⚙ Custom Script Extension

After the VM is created, Azure Custom Script Extension executes a shell script.

The script performs:

- Update Linux packages
- Install Nginx
- Start Nginx service
- Enable Nginx on boot

Result:

The web server is fully configured immediately after deployment without any manual login.

---

# 📂 Project Structure

```
.
├── environments/
│   └── dev/
│
├── modules/
│   ├── resource_group/
│   ├── networking/
│   ├── key_vault/
│   ├── virtual_machine/
│   └── storage_account/
│
├── scripts/
│   └── install-nginx.sh
│
├── providers.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── README.md
```

---

# 🛠 Technologies Used

- Terraform
- Microsoft Azure
- Azure Key Vault
- Azure Virtual Machine
- Azure Custom Script Extension
- Linux (Ubuntu)
- Nginx

---

# 📋 Prerequisites

Before running this project, make sure you have:

- Azure Subscription
- Terraform installed
- Azure CLI installed
- Logged into Azure

```
az login
```

---

# 🚀 Deployment

### Initialize Terraform

```
terraform init
```

### Validate

```
terraform validate
```

### Preview

```
terraform plan
```

### Deploy

```
terraform apply
```

---

# 🌐 Verification

After deployment:

- SSH into the VM using the credentials stored in Azure Key Vault.
- Verify Nginx is running:

```
sudo systemctl status nginx
```

or

```
curl localhost
```

You can also open the VM Public IP in your browser:

```
http://<Public-IP>
```

The default Nginx welcome page should appear.

---

# 🔒 Security Best Practices

✔ Credentials stored in Azure Key Vault

✔ No hardcoded passwords

✔ Infrastructure managed through Terraform

✔ Automated software installation

✔ Reusable modular code

---

# 📚 Learning Outcomes

This project helped me understand:

- Infrastructure as Code (IaC)
- Terraform Modules
- Azure Virtual Machines
- Azure Key Vault
- Secret Management
- Custom Script Extension
- Automated VM Configuration
- Secure Infrastructure Deployment

---

# 🔮 Future Enhancements

- VM Scale Set (VMSS)
- Load Balancer
- Azure Bastion
- Private Key Vault
- Managed Identity
- Azure Monitor
- Azure Backup
- CI/CD Pipeline using Azure DevOps or GitHub Actions

---

# 👨‍💻 Author

**Anurag Chauhan**

Azure | Terraform | DevOps Engineer

GitHub:
https://github.com/anurag09081987

---

## ⭐ If you found this project useful, please consider giving it a Star.

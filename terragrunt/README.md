# 🚀 Terragrunt Project for Infrastructure Setup on AWS

This project automates the creation and setup of infrastructure on **Amazon Web Services (AWS)** using **Terragrunt**, **Packer**, and **Ansible**. It includes the configuration of various AWS resources and automates the process of updating the website hosted on **Nginx**.

---

## 🛠 Key Components

- **Terragrunt + Terraform Modules**  
  - For creating and managing AWS infrastructure.

- **Packer**  
  - For creating **AMIs** (Amazon Machine Images) to deploy infrastructure quickly and efficiently.

- **VPC (Virtual Private Cloud)**  
  - For creating an isolated network.

- **Security Groups**  
  - For managing access to AWS resources.

- **ALB (Application Load Balancer)**  
  - For load balancing across web servers.

- **ASG (Auto Scaling Group)**  
  - For automatically scaling web servers.

- **IAM (Identity and Access Management)**  
  - For managing access to AWS resources.

- **SSL Certificate**  
  - For setting up secure connections over HTTPS.

- **CloudWatch**  
  - For monitoring and logging events.

- **S3 Backend**  
  - For storing **Terraform** state in **S3**, managed by **Terragrunt**.

- **Ansible**  
  - For automating the update of content on **Nginx** web servers.

- **GitHub Actions**  
  - For automating the **CI/CD** pipeline (Continuous Integration and Continuous Deployment).

---

## 📝 Description

This project sets up the infrastructure for the website [https://tryandcry.pp.ua/](https://tryandcry.pp.ua/) on **AWS** using **Terragrunt** and **Terraform modules**. The infrastructure includes:

- **VPC** (Virtual Private Cloud), **Security Groups**, and **ALB** (Application Load Balancer) for network and access management.
- **Auto Scaling Groups (ASG)** for scaling web servers based on demand.
- **IAM** roles for secure access to resources.
- **SSL certificates** to ensure secure access over HTTPS.
- **AMIs** created with **Packer** for quick and efficient deployment.

The **Terraform state** is managed using **Terragrunt**, which stores the state in an **S3 bucket** with versioning enabled. A **DynamoDB table** is used for state locking, ensuring that concurrent updates are handled safely.

Each module in the project uses a **separate S3 bucket** to store its **Terraform state**, providing isolation and easy management. This also prevents state conflicts and guarantees safe concurrent access.

**GitHub Actions** automates the CI/CD pipeline. The pipeline includes the following steps:

1. **Packer Build**: Automatically builds new AMIs for infrastructure.
2. **Terragrunt Infrastructure Setup**: Provisions AWS resources based on the defined infrastructure.
3. **Ansible Deployment**: Updates the content on **Nginx** web servers.

Every change made to the repository triggers the pipeline, ensuring that infrastructure and website content are always up to date.

---

## 🗂 Project Structure

- **`terragrunt/environments/dev`**  
  Configuration for the development environment:
  - Manages infrastructure for VPC, subnets, and route tables.
  - Configures security groups and IAM roles.
  - Creates load balancers and auto-scaling groups.
  - Configures SSL certificates and integrates with CloudWatch for monitoring.
  - Configures the backend using **S3** and **DynamoDB** for **Terraform** state management.

- **`ansible`**  
  Directory containing the Ansible playbook:
  - Automates the process of updating content on **Nginx** servers.

- **`.github/workflows/terragrunt.yml`**  
  Configuration for **GitHub Actions** to automate the CI/CD process:
  - **Linting**: Checks **Terraform** code for errors.
  - **Plan**: Runs `terragrunt plan` to plan infrastructure changes.
  - **Apply**: Runs `terragrunt apply` to provision the infrastructure.
  - **Update**: Runs an **Ansible** playbook to update the content on the **Nginx** server.

- **`ansible/playbook.yml`**  
  Ansible playbook used to update website content on the **Nginx** server.

---

## ⚙️ How to Use

### 1. Initialize and Apply Configuration

Navigate to the `terragrunt/environments/dev` directory and run the following commands:

```bash
cd terragrunt/environments/dev
terragrunt run-all init
terragrunt run-all apply

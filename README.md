# 🚀 Terraform Project for Infrastructure Setup on AWS

This project automates the creation and setup of infrastructure on **Amazon Web Services (AWS)** using **Terraform**. The project includes the configuration of various resources such as:

- **VPC (Virtual Private Cloud)**  
  - For creating an isolated network.

- **Security Groups**  
  - For managing access to resources.

- **ALB (Application Load Balancer)**  
  - For load balancing on web servers.

- **ASG (Auto Scaling Group)**  
  - For automatic scaling of servers.

- **IAM (Identity and Access Management)**  
  - For managing access to AWS resources.

- **SSL Certificate**  
  - For setting up secure connections over HTTPS.

- **CloudWatch**  
  - For monitoring and logging events.

- **Domain**  
  - For setting up a domain for accessing your website.

- **Packer**  
  - For creating **AMIs** (Amazon Machine Images) for your infrastructure.

- **Backend**  
  - For setting up a backend to store **Terraform** state in external storage.

- **GitHub Actions**  
  - For configuring the **CI/CD** process (Continuous Integration and Continuous Deployment).

---

## 📝 Description

This project sets up infrastructure for the website [https://tryandcry.pp.ua/](https://tryandcry.pp.ua/) on the **AWS** platform. The website operates with an SSL certificate and a domain to ensure secure access over HTTPS.

The code is stored in **GitHub** and the **GitHub Actions** are used to automate the deployment process. With CI/CD pipelines, any changes made to the repository are automatically checked, tested, and deployed to the infrastructure, ensuring continuous development and stability of the project.

---

## 🗂 Project Structure

1. **`main.tf`**  
   The main file containing the configuration for all resources:
   - Creation of **VPC**, subnets, and route tables.
   - Configuration of **Security Groups** for access control.
   - Creation of **Load Balancer** and **Auto Scaling Group** for high availability and scalability.
   - Setup of **SSL certificates** and **CloudWatch** for monitoring.
   - Usage of **AMIs** created with **Packer** to ensure fast deployment of new instances.

2. **`variables.tf`**  
   Contains variables that can be configured by the user to adapt to different environments.

3. **`outputs.tf`**  
   Contains output values to display important parameters after infrastructure creation, such as the URL for accessing the site.

4. **`locals.tf`**  
   Configuration of local variables to make managing the configuration easier and more organized.

5. **`packer/`**  
   Directory for setting up **Packer** to create **AMIs** used in the **Auto Scaling Group**.

6. **`backend.tf`**  
   Contains backend configuration for **Terraform** to store the infrastructure state in external storage (specifically in **S3**). Versioning is enabled on the S3 bucket to ensure state versioning.

7. **`.github/workflows/terraform.yml`**  
   File containing **GitHub Actions** configuration for automating the **CI/CD** pipeline. The pipeline includes the following stages:
   - **Build**: Check and build **Terraform** files.
   - **Test**: Test **Terraform** configurations before deployment.
   - **Deploy**: Automatically deploy to **AWS** after successful testing.

---

## ⚙️ How to Use

### 1. Initialize and Apply Configuration

Navigate to the project directory and run the following commands:

```bash
terraform init
terraform apply

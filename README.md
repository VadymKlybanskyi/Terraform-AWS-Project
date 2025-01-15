# Terraform Project for Infrastructure Setup on AWS

This project automates the creation and setup of infrastructure on Amazon Web Services (AWS) using Terraform. The project includes the configuration of various resources such as:

- **VPC (Virtual Private Cloud)** — for creating an isolated network.
- **Security Groups** — for managing access to resources.
- **ALB (Application Load Balancer)** — for load balancing on web servers.
- **ASG (Auto Scaling Group)** — for automatic scaling of servers.
- **IAM (Identity and Access Management)** — for managing access to AWS resources.
- **SSL Certificate** — for setting up secure connections over HTTPS.
- **CloudWatch** — for monitoring and logging events.
- **Domain** — setting up a domain for accessing your website.
- **Packer** — for creating AMIs (Amazon Machine Images) for your infrastructure.
- **Backend** — for setting up a backend to store Terraform state in external storage.
- **GitHub Actions** — for configuring the CI/CD process (Continuous Integration and Continuous Deployment).

## Description

This project sets up infrastructure for the website **https://tryandcry.pp.ua/** on the AWS platform. The website operates with an SSL certificate and a domain to ensure secure access over HTTPS.

**GitHub** is used as the repository to store the code, and also to automate the deployment process via **GitHub Actions**. With CI/CD pipelines, changes in the repository are automatically checked, tested, and deployed to the infrastructure, ensuring stability and continuous project development.

### Project Structure

1. **main.tf** — the main file that contains the configuration for all resources:
   - Creation of VPC, subnets, and route tables.
   - Configuration of Security Groups for access control.
   - Creation of Load Balancer and Auto Scaling Group for high availability and scalability.
   - Setup of SSL certificates and CloudWatch for monitoring.
   - Usage of AMIs created with Packer to ensure fast deployment of new instances.

2. **variables.tf** — the file that contains variables that can be configured by the user for adapting to different environments.

3. **outputs.tf** — the file that contains output values to display important parameters after infrastructure creation, such as the URL for accessing the site.

4. **locals.tf** — configuration of local variables that make managing the configuration and organizing values for use in Terraform easier.

5. **packer** — the directory for setting up Packer to create AMIs used in the Auto Scaling Group.

6. **backend.tf** — the file that contains backend configuration for Terraform to store the infrastructure state in external storage, specifically in S3. Versioning must be enabled on the S3 bucket to store versions.

7. **.github/workflows/terraform.yml** — the file containing the GitHub Actions configuration for automating the CI/CD process. The pipeline includes the following stages:
   - **Build**: Check and build Terraform files.
   - **Test**: Test Terraform configurations before deployment.
   - **Deploy**: Automatically deploy to AWS after successful testing.

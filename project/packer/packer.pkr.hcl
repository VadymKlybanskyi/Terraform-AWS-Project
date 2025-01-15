packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "packer-dev-{{timestamp}}"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami    = "ami-0866a3c8686eaeeba"
  ssh_username  = "ubuntu"

  tags = {
    Name        = "packer-dev-v1.0.{{isotime}}"
    Environment = "Development"
    Owner       = "Devops"
    Purpose     = "Terraform project"
  }
}

build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "file" { # Transferring docker-compose to the EC2 server
    source      = "docker-compose.yaml" 
    destination = "/home/ubuntu/docker-compose.yaml"  
  }

  provisioner "file" { # Transferring custom webpage for the website
    source      = "index.html"  
    destination = "/home/ubuntu/index.html"
  }

  provisioner "file" { # Transferring nginx.conf
    source      = "nginx.conf"  
    destination = "/home/ubuntu/nginx.conf"
  }

  provisioner "shell" {
    inline = [
      # System update
      "sudo apt-get update -y",
      "sudo apt-get upgrade -y",

      # Installing Docker and Docker Compose
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\"",
      "sudo apt-get update -y",
      "sudo apt-get install -y docker-ce docker-compose",

      # Starting and enabling Docker
      "sudo systemctl start docker",
      "sudo systemctl enable docker",

      # Adding user to the docker group to avoid Permission Denied issues
      "sudo usermod -aG docker ubuntu",

      # Creating logs folder for logs
      "mkdir -p /home/ubuntu/logs",
      "sudo chmod -R 777 /home/ubuntu/logs",

      # Checking Docker and Docker Compose versions
      "sudo docker --version",
      "sudo docker-compose --version"
    ]
  }
}

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

  provisioner "file" { # Переносимо docker-compose на сервер EC2
    source      = "docker-compose.yaml" 
    destination = "/home/ubuntu/docker-compose.yaml"  
  }

  provisioner "file" { # Переносимо кастомну сторінку для веб-сайту
    source      = "index.html"  
    destination = "/home/ubuntu/index.html"
  }

    provisioner "file" { # Переносимо nginx.conf
    source      = "nginx.conf"  
    destination = "/home/ubuntu/nginx.conf"
  }

  provisioner "shell" {
    inline = [
      # Оновлення системи
      "sudo apt-get update -y",
      "sudo apt-get upgrade -y",

      # Встановлення Docker і Docker Compose
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\"",
      "sudo apt-get update -y",
      "sudo apt-get install -y docker-ce docker-compose",

      # Запуск та увімкнення Docker
      "sudo systemctl start docker",
      "sudo systemctl enable docker",

      # Додавання користувача до групи docker для уникнення проблем Permission Denied
      "sudo usermod -aG docker ubuntu",

      # Створення папки logs для логів
      "mkdir -p /home/ubuntu/logs",
      "sudo chmod -R 777 /home/ubuntu/logs",

      # Перевірка версій Docker і Docker Compose
      "sudo docker --version",
      "sudo docker-compose --version"
    ]
  }
}

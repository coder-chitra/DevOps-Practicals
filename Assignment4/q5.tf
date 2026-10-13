
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.0"
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "web_sg" {
  name        = "mini-finance-security-group"
  description = "Allow SSH and HTTP traffic"

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MiniFinanceSecurityGroup"
  }
}

resource "aws_instance" "mini_finance" {
  ami                    = "ami-00bb6a80f"
  instance_type          = "t2.micro"
  key_name               = "mykey"
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  user_data = <<-EOF
    #!/bin/bash
    set -e

    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      apache2 wget unzip vim

    cd /tmp
    wget -O mini-finance.zip \
      https://www.tooplate.com/zip-templates/2135_mini_finance.zip

    mkdir -p /tmp/mini-finance
    unzip -o mini-finance.zip -d /tmp/mini-finance

    find /tmp/mini-finance -name index.html -print -quit \
      > /tmp/index-location.txt

    INDEX_FILE=$(head -n 1 /tmp/index-location.txt)

    if [ -z "$INDEX_FILE" ]; then
      echo "index.html not found in downloaded template" \
        > /var/www/html/index.html
      exit 1
    fi

    WEBSITE_DIR=$(dirname "$INDEX_FILE")

    cp -r "$WEBSITE_DIR"/. /var/www/html/
    chown -R www-data:www-data /var/www/html

    systemctl enable apache2
    systemctl restart apache2
  EOF

  tags = {
    Name = "MiniFinanceWebServer"
  }
}

output "instance_id" {
  value = aws_instance.mini_finance.id
}

output "public_ip" {
  value = aws_instance.mini_finance.public_ip
}


# terraform init
# terraform validate
# terraform plan
# terraform apply
# terraform output
# terraform destroy
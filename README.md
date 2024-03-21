# terraform-YouTube

# **First give provide Information:**
- `provider.tf`

```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}
```

# **Install EC2-Instance & Security Groups Using Terrafrom:**
- `ec2.tf`

```
resource "aws_security_group" "demo_sg" {
  name        = "security group using terraform"
  description = "security group using terraform"
  vpc_id      = "vpc-0d096b2c1d33a1aba"

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "TF_SG"
  }
}

resource "aws_instance" "web" {
  ami             = "ami-03bb6d83c60fc5f7c"     # Ubuntu AMI
  instance_type   = "t2.micro"
  key_name        = "mumbai"     # Change key_pair
  vpc_security_group_ids = [aws_security_group.demo_sg.id]

  tags = {
    Name = "HelloWorld"
  }

  user_data = file("script.sh")

}
```

# **EC2-Userdata file:**
- `script.sh`

```
#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "Hello Vijay Giduthuri" | sudo tee /var/www/html/index.html 
```

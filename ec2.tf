resource "aws_instance" "web" {
  ami           = "ami-0e670eb768a5fc3d4"   
  instance_type = "t2.micro"
  security_groups = [aws_security_group.TF_SG.name]

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_security_group" "TF_SG" {
  name        = "security group using terraform"
  description = "security group using terraform"
  vpc_id      = "vpc-0d096b2c1d33a1aba"          # change VPC_ID

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

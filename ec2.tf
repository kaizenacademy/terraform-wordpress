provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "template_file" "phpconfig" {
  template = file("wp-config.php")

  vars = {
    db_host = aws_db_instance.mysql.endpoint
    db_user = var.db_user
    db_pass = var.db_pass
    db_name = var.db_name
  }
}

resource "aws_instance" "group-3" {
  ami           = data.aws_ami.Amazon-linux2.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.main1.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data = file("apache.sh")
  associate_public_ip_address = true



  tags = {
    Name = "group-3"
  }
}

data "aws_ami" "Amazon-linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
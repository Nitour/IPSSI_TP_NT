data "aws_ami" "selected" {
  most_recent = true
  owners      = var.ami_filter.owners

  filter {
    name   = "name"
    values = [var.ami_filter.name_pattern]
  }

  filter {
    name   = "architecture"
    values = [var.ami_filter.architecture]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_instance" "ec2_web" {
  count = var.instance_count

  ami                         = data.aws_ami.selected.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_ids[count.index % length(var.subnet_ids)]
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_pair_name
  associate_public_ip_address = true

user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
              echo '<h1>SERVER WEB - '"$INSTANCE_ID"'</h1>' > /var/www/html/index.html
              systemctl start nginx
              EOF



  tags = {
    Name = "servweb${count.index + 1}"
    Role = "web"
  }
}

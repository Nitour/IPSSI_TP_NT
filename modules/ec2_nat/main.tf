data "aws_ami" "debian" {
  most_recent = true
  owners      = ["136693071363"]

  filter {
    name   = "name"
    values = ["debian-11-amd64-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "nat" {
  count         = var.enable_nat_instance ? 1 : 0
  ami           = data.aws_ami.debian.id
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.sg_id]
  source_dest_check           = false
  key_name = "terraform"

  user_data = <<-EOF
              #!/bin/bash
              echo 1 > /proc/sys/net/ipv4/ip_forward
              iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
              EOF

  tags = {
    Name = "nat-instance-nt"
  }
}

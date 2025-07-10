data "http" "myip" {
  url = "https://checkip.amazonaws.com"
}

resource "aws_security_group" "nat_sg" {
  name        = "nat-sg-nt"
  description = "Allow outbound internet for NAT"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]

  }

  tags = {
    Name = "nat-sg-nt"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg-nt"
  description = "Allow HTTP traffic from anywhere"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg-nt"
  }
}


resource "aws_security_group" "alb_sg" {
  name        = "alb-sg-nt"
  description = "Security Group pour l equilibreur de charge (ALB)"
  vpc_id      = var.vpc_id

  # Autoriser le trafic HTTP depuis Internet vers le Load Balancer
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Autoriser tout en sortie
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg-nt"
  }
}

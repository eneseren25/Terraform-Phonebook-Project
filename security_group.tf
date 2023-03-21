resource "aws_security_group" "alb-sec-group" {
  name        = "alb-sec-group"
  description = "Allow http"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.aws_alb_sec_group
    iterator = port

    content {
      description = "HTTP"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "All"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "alb-sec-group"
  }
}

resource "aws_security_group" "ec2-sec-group" {
  name        = "ec2-sec-group"
  description = "Allow ssh and http ports"

  vpc_id = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.aws_ec2_sec_group
    iterator = port

    content {
      description     = "HTTP,SSH"
      from_port       = port.value
      to_port         = port.value
      protocol        = "tcp"
      security_groups = [aws_security_group.alb-sec-group.id]
    }
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "all"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  tags = {
    "Name" = "ec2-sec-group"
  }
}

resource "aws_security_group" "db-sec-grp" {
  name        = "rds-sec-grp"
  description = "rds-sec-group"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.aws_rds_sec_group
    iterator = port

    content {
      from_port       = port.value
      to_port         = port.value
      protocol        = "tcp"
      security_groups = [aws_security_group.ec2-sec-group.id]
    }
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "all"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  tags = {
    "Name" = "rds-sec-group"
  }
}
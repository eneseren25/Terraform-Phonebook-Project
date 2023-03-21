data "aws_ami" "launch_data" {
  owners      = ["amazon"]
  most_recent = true # The Latest one I am going to choose from amazon store

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"] # This is enough for define my ami-type(version), but the others can be write
  }

}

/* data "aws_subnets" "phonebook" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.default-vpc-subnets.ids]
  }
} */

data "aws_subnets" "default-vpc-subnets" {
  filter {
    name   = "tag:Name"
    values = ["my-${var.mytag}-public-1a","my-${var.mytag}-public-1b"]
  }
}

data "aws_subnet" "public" {
  for_each = toset(data.aws_subnets.default-vpc-subnets.ids)
  id       = each.value
}
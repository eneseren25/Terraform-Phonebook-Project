output "vpc_id" {
  value     = aws_vpc.main.id
  sensitive = false # you can hide your important outputs with this default = false
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

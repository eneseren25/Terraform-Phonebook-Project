variable "mytag" {
  default = "phonebook"
}

variable "aws_alb_sec_group" {
  type    = list(number)
  default = [80]
}

variable "aws_ec2_sec_group" {
  type    = list(number)
  default = [22, 80]
}

variable "aws_rds_sec_group" {
  type    = list(number)
  default = [3306]
}

variable "aws_launch_instance_type" {
  description = "to definde instance type of launch template"
  type        = string
  default     = "t2.micro"
}

variable "aws_launch_key_pair" {
  description = "to definde key-pair of launch template"
  type        = string
  default     = "clarusway_lesson_key"
}
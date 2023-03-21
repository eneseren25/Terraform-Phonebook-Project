resource "aws_autoscaling_group" "asg-group" {
  name                      = "${var.mytag}-auto-scaling-group"
  max_size                  = 5
  min_size                  = 1
  desired_capacity          = 2
  health_check_grace_period = 250 # The first 250 second won't check anything
  health_check_type         = "ELB"
  force_delete              = true
  /* launch_configuration      = "" */ # - (Optional) Name of the launch configuration to use.
  vpc_zone_identifier = [aws_subnet.public-1b.id, aws_subnet.public-1a.id]
  target_group_arns   = [aws_lb_target_group.targett.arn]

  launch_template {
    id      = aws_launch_template.aws_lt.id
    version = "$Latest" # That's gonna chooese our latest version of launch template 
  }
}
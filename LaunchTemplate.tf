resource "aws_launch_template" "aws_lt" {
  name = "my-launch-template"

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 20
    }
  }

  image_id      = data.aws_ami.launch_data.id
  instance_type = var.aws_launch_instance_type
  key_name      = var.aws_launch_key_pair

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "my-${var.mytag}-launch-template"
    }
  }
  user_data = filebase64("${path.module}/user-data.sh")

  /* depends_on = [
    xxxxxxxxxxxxxxxxxxxxxxx
    xxxxxxxxxxxxxxxxxxxxxxx # You can use this part for GitHub...
  ] */
}
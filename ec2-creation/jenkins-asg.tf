resource "aws_launch_template" "jen-template" {
  name                   = "jenkins-template"
  image_id               = "agent-ami"
  instance_type          = "t2.micro"
  key_name               = "manas-terraform-learning"
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  tags = {
    Name      = "jenkins-launch-template"
    ManagedBy = "Terraform"
  }
}

resource "aws_autoscaling_group" "jenkins_asg" {
  launch_template {
    id      = aws_launch_template.jen-template.id
    version = "$Latest"
  }
  availability_zones = "ap-south-1a"
  min_size           = 0
  max_size           = 1
  desired_capacity   = 0
  tags = {
    Name = "jenkins"
  }
}
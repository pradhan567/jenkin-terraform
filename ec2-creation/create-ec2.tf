resource "aws_instance" "terra" {
  ami                  = "ami-0af9569868786b23a"
  instance_type        = "t2.micro"
  availability_zone    = "ap-south-1a"
  key_name             = "manas-terraform-learning"
  subnet_id            = aws_subnet.private-sub-1.id
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  iam_instance_profile = aws_iam_instance_profile.jenkins_instance_profile.name
  user_data            = file("${path.module}/install_jenkins.sh")
  tags = {
    Name      = "jenkins"
    ManagedBy = "Terraform"
  }
}

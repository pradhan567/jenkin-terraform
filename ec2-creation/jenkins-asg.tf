# resource "aws_launch_template" "jen-template"{
#     name = "jenkins-template"
#     image_id = "ami-0f918f7e67a3323f0"
#     instance_type = "t2.micro"
#     key_name = "jenkins-key"
#     iam_instance_profile {
#         name = aws_iam_instance_profile.jenkins_instance_profile.name
#     }
#     network_interfaces {
#         associate_public_ip_address = true
#         subnet_id = "ap-south-1a" 
#         security_groups = ["aws_security_group.jenkins_sg.id"]
#     }
#     tags = {
#         Name = "jenkins-launch-template"
#         ManagedBy = "Terraform"
#     }
# }

# resource "aws_autoscaling_group" "jenkins_asg" {
#     launch_template {
#         id = aws_launch_template.jen-template.id
#         version = "$Latest"
#     }
#     min_size = 1
#     max_size = 3
#     desired_capacity = 2
#     vpc_zone_identifier = ["subnet-0bb1c79de3EXAMPLE"]
#     health_check_type = "EC2"
#     health_check_grace_period = 300
#     force_delete = true
# }
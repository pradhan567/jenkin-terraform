resource "aws_iam_role" "jenkins_role" {
  name = "jenkins-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name      = "jenkins-role"
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_role_policy" "jenkins_permissions" {
  name = "jenkins-permissions"
  role = aws_iam_role.jenkins_role.id

  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Action"   = "ec2:*",
        "Effect"   = "Allow",
        "Resource" = "*"
      },
      {
        "Effect"   = "Allow",
        "Action"   = "elasticloadbalancing:*",
        "Resource" = "*"
      },
      {
        "Effect"   = "Allow",
        "Action"   = "cloudwatch:*",
        "Resource" = "*"
      },
      {
        "Effect"   = "Allow",
        "Action"   = "autoscaling:*",
        "Resource" = "*"
      },
      {
        "Effect"   = "Allow",
        "Action"   = "iam:CreateServiceLinkedRole",
        "Resource" = "*",
        "Condition" = {
          "StringEquals" = {
            "iam:AWSServiceName" = [
              "autoscaling.amazonaws.com",
              "ec2scheduled.amazonaws.com",
              "elasticloadbalancing.amazonaws.com",
              "spot.amazonaws.com",
              "spotfleet.amazonaws.com",
              "transitgateway.amazonaws.com"
            ]
          }
        }
      }
    ]
  })
}

resource "aws_iam_instance_profile" "jenkins_instance_profile" {
  name = "jenkins-instance-profile"
  role = aws_iam_role.jenkins_role.name
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.jenkins_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

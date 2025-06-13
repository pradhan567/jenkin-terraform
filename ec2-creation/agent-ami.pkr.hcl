packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name          = "agent-ami"
  instance_type     = "t2.micro"
  region            = "ap-south-1"
  availability_zone = "ap-south-1a"
  source_ami        = "ami-0f918f7e67a3323f0"
  ssh_username      = "ubuntu"
  tags = {
    Name = "agent-ami"
  }
}

build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "shell" {
    inline = [
      "sudo apt install openjdk-17-jdk -y"
    ]
  }
}

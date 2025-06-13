resource "null_resource" "stop_jenkins_remote" {
  triggers = {
    instance_ip = aws_instance.terra.public_ip
  }

  provisioner "remote-exec" {
    when   = destroy
    inline = ["sudo docker stop jenkins || true"]

    connection {
      type        = "ssh"
      host        = self.triggers.instance_ip
      user        = "ec2-user"
      private_key = file("manas-terraform-learning.pem")
    }
  }
}
resource "aws_volume_attachment" "jenkins_vol_attachment" {
  volume_id   = "vol-0dbe2a7091b2b9404"
  instance_id = aws_instance.terra.id
  device_name = "/dev/sdf"
  depends_on  = [aws_instance.terra]
}


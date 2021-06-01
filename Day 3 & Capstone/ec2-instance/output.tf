output "instance_ip" {
  description = "public ip of instance"
  value = aws_instance.instance1.public_ip
}
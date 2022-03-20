provider "aws" {
  region     = "${var.aws_region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"

}

resource "aws_instance" "server" {
  ami             = "${var.ami}"
  instance_type   = "${var.instance_type}"
  subnet_id       = "${var.subnet_id}"
  security_groups = "${var.security_groups}"
  key_name        = aws_key_pair.key.id

  tags = {
    Name = "Akhil"
}
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install apache2 -y",
      "sudo service apache2 start"

    ]
     connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("assign1.pem")
      host        = aws_instance.server.public_ip
   }
  }
 }

resource "aws_key_pair" "key" {
  key_name   = "assign1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6xVFchzizOIsXpjGZQ8FD/1Qgvo0Ki/sfrX5hX1YHsb4ylfNgUm6A3lCVn1oAKBqLB7zWCzVL81vwpbtjMG1gLe+RiLTM0GG+6sr/1EPvCSb1ocMN7oc5bpyAYptVl+EgSX3UzW3PUxoE2zvMR/okRZZFB3YRop9SKjUShM74+RTB2u2pEv4eyR1PcBjAs6kCGk/gdNrRuYFRwWDutJ6Ymn43L3tis+6UvAR8AMAaAiOrDprGwNTTQ6MOAlGjC4LjjEronkMY2eRSxaIEC75KOm/1wnTzUFxt8WIoh1+cBqdhqDR2V82StuSv1xDmPCycfZtcfqd8EQhK0zI7wvagHp3j3+OrpWfiwBY7/Cr4XxQyhDUstC7hsRnoNITU38Jf3eFkI8JiQtzna5bMsbTy1i+EaRPcUclYyRGLlYZv7EuLuPH8h5hHCDknEYaPUrqWAEpr3Y4c6791o2kgCC7siL4Xko92/rQMdZnE2222sY7fiFxYmJzziB9da3nsgrc= root@ip-10-1-1-18"
}

resource "aws_ebs_volume" "akhil-volume" {
  availability_zone = "${var.availability_zone}"
  size              = "${var.size}"

  tags = {
    Name = "akhilebs"
  }
}

resource "aws_volume_attachment" "akhil-volumeattachment" {
  device_name = "${var.device_name}"
  volume_id   = aws_ebs_volume.akhil-volume.id
  instance_id = aws_instance.server.id
}



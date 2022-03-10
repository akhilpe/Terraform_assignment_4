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
      private_key = file("camel1.pem")
      host        = aws_instance.server.public_ip
   }
  }
 }

resource "aws_key_pair" "key" {
  key_name   = "camel1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCrpatzHA4wNTSm2ROfybXGD8hTIvMxf0hQmeM/ZGIFCiPd0KGEjeKrUCN43ysoNfIw2KpmtrXp4Li7nBtmAlwohoAssMbE8vws4lADtlsbWu1ffEqcS7FdynAO1BiBabRJ/OZuyxJG8tpVSSppIhTLaloQpvCmCTRVnuKfxYFT3Cwx8ZUb1oSGwvfNkFDrdjiz3BMwHDnCJM4xCvQKAh5nhVd+4hdj5e+CYRzqV54glW3Vu/AeRChOSebnvdpm6K6Zi86Sx/GkJ66SER2+rv6nUnisU03dDMd13ox6gpMkez3eYYSCnGLDuZa7Jx4PKdLuautWexoOgGSWH3568YZ1 akhil_gnanamukth@PSL-7179QG3"
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



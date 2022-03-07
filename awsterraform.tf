provider "aws" {

  region     = "us-east-1"
  access_key = "AKIASZ5O5XHCJDGMQXLQ"
  secret_key = "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"

}

resource "aws_instance" "server" {
  ami             = "ami-04505e74c0741db8d"
  instance_type   = "t2.micro"
  subnet_id       = "subnet-03192047718cb5fc5"
  security_groups = ["sg-09d52350cf22e1efe"]
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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCCfcWuwOo3B//LjAOmElmP2OK5XxBDZI7vGUn6QLoNEEVgGMkJ9COJwTeOm9RR6Xg0fUp/O5Idm35JOWOuuuqNcq+B7azXSCSqbVg0MDGwfCnsbhywHriENUAfeBCy3vCWdzvLx2V0w6pVJw2M2FdBdCnX0oMEE92u/qqNyf/DRVOLvAt9a+v1apfuP6kFGMfCN4imLgOyo3D4d6tp8EujQBP5PWEzqgx34M4YnXPajrz+oszAlQ6K78h/mN+i12sq+3T0eoJ5dX9TlE6LuGy5Btp+m7MpW+iwcnJt+fTrw+HV37D/JBU7RmhC5IJ99MrH2+azLFgPIU5wGsafejmF imported-openssh-k"
}
resource "aws_ebs_volume" "akhil-volume" {
  availability_zone = "us-east-1c"
  size              = 12

  tags = {
    Name = "akhilebs"
  }
}

resource "aws_volume_attachment" "akhil-volumeattachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.akhil-volume.id
  instance_id = aws_instance.server.id
}

terraform {
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }
  }
}


provider "http" {
  # Configuration options
}

data "http" "example" {
  url = "https://checkpoint-api.hashicorp.com/v1/check/terraform"

  # Optional request headers
  request_headers = {
    Accept = "application/html"
  }
}


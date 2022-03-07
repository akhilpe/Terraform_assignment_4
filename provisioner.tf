resource "null_resource" "ec2-script" {
  provisioner "file" { # it copys file
    source      = "index.html"
    destination = "/tmp/index.html"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("camel1.pem")
      host        = aws_instance.server.public_ip
    }
  }

  provisioner "file" {
    source      = "public_key"
    destination = "/tmp/public_key"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("camel1.pem")
      host        = aws_instance.server.public_ip
    }
  }

  provisioner "local-exec" {
    command = <<EOH
      ./index.html >> output_details,
    EOH
  }

  /* 
  provisioner "remote-exec" { #it execute file 
    inline = [
      "chmod +x /tmp/index.html",
      "sudo /tmp/index.html",
    ] */

  /* connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("camel1.pem")
      host        = aws_instance.server.public_ip
    }
  } */
}
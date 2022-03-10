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
}



  

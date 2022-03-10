resource "null_resource" "destroy" {
  triggers = {
    public_ip = aws_instance.server.public_ip
    #private_ip = some_value
  }
  provisioner "remote-exec" {
    when = destroy
    inline = [
      "rm -f /tmp/index.html",
      "rm -f apache2",  
    ]

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("camel1.pem")
      host = self.triggers.public_ip
    }
  }
}

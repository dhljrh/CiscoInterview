terraform {
  backend "s3" {
    bucket = "dons-terraform-bucket"
    key = "terraform/webserver/terraform.tfstate"
    region = "us-east-1"

  }
}


provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "appserver" {
  associate_public_ip_address = "false"
  ami           = "ami-0cff7528ff583bf9a"
  instance_type = "t2.micro"
  subnet_id = "subnet-0cee4d9724f3d9a2a"
  key_name = "ssh-key-don"
  provisioner "remote-exec" {
    inline = [
      "sudo yum -y install httpd && sudo systemctl start httpd",
      "echo '<h1><center>This is the code I wrote for the Cisco exam please excuse the mess</center></h1>' > index.html",
      "sudo mv index.html /var/www/html"
    ]
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host = self.private_ip
    }
  }

  tags = {
    Name = "dontest2"
  }
}

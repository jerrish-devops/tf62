resource "aws_key_pair" "demo_ssh_pub_key" {
  key_name   = "terraform-class"
  public_key = file(var.ssh_pub_key)
}

data "aws_ami" "updated_ami" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_instance" "demo_instance1" {
  tags = {
    Name = "${var.environment} server1 - Provisioned by TF"
    Dept = "devops"
  }
  ami                    = "ami-022d03f649d12a49d" #data.aws_ami.updated_ami.image_id
  instance_type          = var.instance_type["development"]
  subnet_id              = aws_subnet.demo_subnet1.id
  vpc_security_group_ids = [aws_security_group.demo_sg.id]
  key_name               = aws_key_pair.demo_ssh_pub_key.key_name

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > public_ip.txt"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.public_ip
    private_key = file("./terraform-class")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install php8.0 mariadb10.5 -y",
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo mkdir /var/www/inc",
      "sudo chown -R ec2-user /var/www"
    ]
  }

  provisioner "file" {
    source      = "./index.php"
    destination = "/var/www/html/index.php"
  }

  provisioner "file" {
    content     = <<-EOF
    <?php

define('DB_SERVER', '${aws_db_instance.demo_rds.address}');
define('DB_USERNAME', '${var.db_username}');
define('DB_PASSWORD', '${var.db_password}');
define('DB_DATABASE', 'students');

?>
  EOF
    destination = "/var/www/inc/dbinfo.inc"
  }

}

/*
resource "aws_instance" "demo_instance2" {
  tags = {
    Name = "${var.environment} server2 - Provisioned by TF"
    Dept = "devops"
  }
  ami                    = data.aws_ami.updated_ami.image_id
  instance_type          = var.instance_type["development"]
  subnet_id              = aws_subnet.demo_subnet2.id
  vpc_security_group_ids = [aws_security_group.demo_sg.id]
  key_name = aws_key_pair.demo_ssh_pub_key.key_name
}
*/
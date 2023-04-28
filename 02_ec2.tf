resource "aws_key_pair" "demo_ssh_pub_key" {
  key_name = "terraform-class"
  public_key = file(var.ssh_pub_key)
}

data "aws_ami" "updated_ami" {
  owners = ["amazon"]
  most_recent = true
  filter {
    name = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_instance" "demo_instance1" {
  tags = {
    Name = "${var.environment} server1 - Provisioned by TF"
    Dept = "devops"
  }
  ami                    = data.aws_ami.updated_ami.image_id
  instance_type          = var.instance_type["development"]
  subnet_id              = aws_subnet.demo_subnet1.id
  vpc_security_group_ids = [aws_security_group.demo_sg.id]
  key_name = aws_key_pair.demo_ssh_pub_key.key_name
}

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
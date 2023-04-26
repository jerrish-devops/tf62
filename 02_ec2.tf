resource "aws_instance" "demo_instance1" {
  tags = {
    Name = "${var.environment} server1 - Provisioned by TF"
    Dept = "devops"
  }
  ami                    = var.ami[0]
  instance_type          = var.instance_type["development"]
  subnet_id              = aws_subnet.demo_subnet1.id
  vpc_security_group_ids = [aws_security_group.demo_sg.id]
}

resource "aws_instance" "demo_instance2" {
  tags = {
    Name = "${var.environment} server2 - Provisioned by TF"
    Dept = "devops"
  }
  ami                    = var.ami[0]
  instance_type          = var.instance_type["development"]
  subnet_id              = aws_subnet.demo_subnet2.id
  vpc_security_group_ids = [aws_security_group.demo_sg.id]
}
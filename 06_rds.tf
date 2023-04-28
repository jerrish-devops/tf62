/*
resource "aws_db_subnet_group" "demo_db_sg" {
  name       = "tf-rds-subnet-group"
  subnet_ids = [aws_subnet.demo_subnet3.id, aws_subnet.demo_subnet4.id]
}

resource "aws_db_instance" "demo_rds" {
  engine                 = "mysql"
  engine_version         = "8.0.32"
  identifier             = "${var.environment}-rds-mysql"
  username               = var.db_username
  password               = var.db_password
  instance_class         = "db.t3.micro"
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.demo_db_sg.id
  availability_zone      = "ap-south-1a"
  vpc_security_group_ids = [aws_security_group.demo_sg.id]
  skip_final_snapshot    = true
}
*/
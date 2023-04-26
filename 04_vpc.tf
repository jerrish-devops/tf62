resource "aws_vpc" "demo_vpc" {
  tags = {
    Name = "${var.environment}-tf-vpc"
  }
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
}

resource "aws_subnet" "demo_subnet1" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "${var.environment}-tf-vpc-public-subnet1"
  }
  cidr_block              = var.public_subnet1
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "demo_subnet2" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "${var.environment}-tf-vpc-public-subnet2"
  }
  cidr_block              = var.public_subnet2
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "demo_subnet3" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "${var.environment}-tf-vpc-private-subnet1"
  }
  cidr_block        = var.private_subnet1
  availability_zone = "ap-south-1a"
}

resource "aws_subnet" "demo_subnet4" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "${var.environment}-tf-vpc-private-subnet2"
  }
  cidr_block        = var.private_subnet2
  availability_zone = "ap-south-1b"
}

resource "aws_internet_gateway" "demo_igw" {
  tags = {
    Name = "${var.environment}-tf-vpc-igw"
  }
  vpc_id = aws_vpc.demo_vpc.id
}

resource "aws_default_route_table" "demo_vpc_default_rt" {
  tags = {
    Name = "${var.environment}-tf-vpc-default-rt"
  }
  default_route_table_id = aws_vpc.demo_vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_igw.id
  }
}
#common variables

variable "environment" {
  default = "development"
}

# below variables are for ec2

variable "ami" {
  type    = list(any)
  default = ["ami-0c768662cc797cd75", "ami-0fdea1353c525c182", "ami-02eb7a4783e7e9317"]
}

#this is amazon ami - ami-0c768662cc797cd75
#this is rhel ami - ami-0fdea1353c525c182
#this is ubuntu ami - ami-02eb7a4783e7e9317

variable "instance_type" {
  type = map(any)
  default = {
    development = "t2.micro"
    production  = "t2.large"
  }
}

# below variables are for vpc

variable "vpc_cidr" {
  default = "192.168.100.0/24"
}

variable "public_subnet1" {
  default = "192.168.100.0/26"
}

variable "public_subnet2" {
  default = "192.168.100.64/26"
}

variable "private_subnet1" {
  default = "192.168.100.128/26"
}

variable "private_subnet2" {
  default = "192.168.100.192/26"
}

# below variables are for security group

variable "source_ip" {
  default = "0.0.0.0/0"
}
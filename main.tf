terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}
provider "aws" {
  region = var.region
}


module "vpc" {
  source = "../modules/vpc"
  vpc_cidr = var.vpc.cidr
  vpc_tenancy = var.vpc.tenancy
  ENV = var.vpc.ENV
  tags = var.tags
}

module "app-sg" {
  source = "../modules/sg"
  id_vpc = module.vpc.vpc_id
  sg_ingress = var.sg.sg_ingress
  ENV = var.vpc.ENV
}

module "bastion" {
  source = "../modules/ec2"
    ec2_num = var.bastion.ec2_num
    name = var.bastion.name
    instance_type = var.bastion.instance_type
    ami_id = data.aws_ami.ubuntu.id
    sg_id = module.app-sg.sg_id
    subnet_id = module.vpc.pub_subnet_id
    ENV = var.vpc.ENV
    key = var.bastion.key
}

module "web-app-asg" {
  source = "../modules/asg"
  name = var.web-app-asg.name
  launch_temp_name = var.web-app-asg.launch_temp_name
  ami_id = data.aws_ami.ubuntu.id
  instance_type = var.web-app-asg.instance_type
  volume_size = var.web-app-asg.volume_size
  asg_name = var.web-app-asg.asg_name
  min_size = var.web-app-asg.min_size
  max_size = var.web-app-asg.max_size
  desired_capacity = var.web-app-asg.desired_capacity
  subnet_ids = module.vpc.priv_subnet_ids
  sg_id = module.app-sg.sg_id
  key_name = var.web-app-asg.key_name
}

module "backend-app-asg" {
  source = "../modules/asg"
  name = var.backend-app-asg.name
  launch_temp_name = var.backend-app-asg.launch_temp_name
  ami_id = data.aws_ami.ubuntu.id
  instance_type = var.backend-app-asg.instance_type
  volume_size = var.backend-app-asg.volume_size
  asg_name = var.backend-app-asg.asg_name
  min_size = var.backend-app-asg.min_size
  max_size = var.backend-app-asg.max_size
  desired_capacity = var.backend-app-asg.desired_capacity
  subnet_ids = module.vpc.priv_subnet_ids
  sg_id = module.app-sg.sg_id
  key_name = var.backend-app-asg.key_name
}

module "mysql-asg" {
  source = "../modules/asg"
  name = var.mysql-asg.name
  launch_temp_name = var.mysql-asg.launch_temp_name
  ami_id = data.aws_ami.ubuntu.id
  instance_type = var.mysql-asg.instance_type
  volume_size = var.mysql-asg.volume_size
  asg_name = var.mysql-asg.asg_name
  min_size = var.mysql-asg.min_size
  max_size = var.mysql-asg.max_size
  desired_capacity = var.mysql-asg.desired_capacity
  subnet_ids = module.vpc.priv_subnet_ids
  sg_id = module.app-sg.sg_id
  key_name = var.mysql-asg.key_name
}
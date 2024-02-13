vpc = {
    cidr = "10.0.0.0/16"
    tenancy = "default"
    ENV = "dev"
}

region = "ap-south-1"

tags = {
  "AWS_REGION"            = "ap-south-1"
}

bastion = {
    ec2_num = 1
    name = "bastion-host"
    instance_type = "t3a.medium"
    key = "dev-key"
}

sg = {
    sg_ingress = {
                ingress1 = {from="22", to="22", protocol="tcp", cidr_block="0.0.0.0/0", description="SSH"}
                ingress2 = {from="8080", to="8080", protocol="tcp", cidr_block="0.0.0.0/0", description="Jenkins"}
    }
}

web-app-asg = {
    name = "web-app-ec2"
    launch_temp_name = "web-app-lt"
    instance_type = "t3a.medium"
    volume_size = "10"
    asg_name = "web-app-asg"
    min_size = 1
    max_size = 1
    desired_capacity = 1
    key_name = "dev-key"
}

backend-app-asg = {
    name = "backend-app-ec2"
    launch_temp_name = "backend-app-lt"
    instance_type = "t3a.small"
    volume_size = "10"
    asg_name = "backend-app-asg"
    min_size = 1
    max_size = 1
    desired_capacity = 1
    key_name = "dev-key"
}

mysql-asg = {
    name = "mysql-ec2"
    launch_temp_name = "mysql-lt"
    instance_type = "t3a.small"
    volume_size = "10"
    asg_name = "mysql-asg"
    min_size = 1
    max_size = 1
    desired_capacity = 1
    key_name = "dev-key"
}
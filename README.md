I have created these modules:

- VPC module:
    - 3 public subnets
    - 3 private subnets
    - subnets for each Availabilty zone
    - Route tables
    - Internet Gateway
    - NAT Gateway (inside the public subnet)

- EC2 module:
    - Bastion host (inside the public subnet)

- Security Group module

- Auto Scaling Group module:
 - Calling the modules to create three ASGs
   - Web-app ASG (inside the private subnets)
   - backend-app ASG (inside the private subnets)
   - MySQL ASG (inside the private subnets)

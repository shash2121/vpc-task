variable "vpc" {
  default = null
}

variable "region" {
}

variable "tags" {
  
}
variable "bastion" {
  default = null
}
variable "sg" {
  default = null
}

variable "web-app-asg" {
  default = null
}
variable "backend-app-asg" {
  default = null
}

variable "mysql-asg" {
  default = null
}
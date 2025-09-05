variable "aws-region" {}
variable "env" {}
variable "cluster-name" {}
variable "vpc-cidr-block" {}
variable "vpc-name" {}
variable "igw-name" {}
variable "pub-subnet-count" {}
variable "pub-cidr-block" {
  type = list(string)
}
variable "pub-availability-zone" {
  type = list(string)
}
variable "pub-sub-name" {}
variable "public-rt-name" {}
variable "eks-sg" {}


# EKS
variable "cluster-version" {}
variable "endpoint-public-access" {}
variable "max_capacity_spot" {}
variable "node-group-name" {}
variable "instance-types" {}
variable "ec2-ssh-key" {}

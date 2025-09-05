variable "cluster-name" {}
variable "cidr-block" {}
variable "vpc-name" {}
variable "env" {}
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

#IAM
variable "is_eks_role_enabled" {
  type = bool
}
variable "is_eks_nodegroup_role_enabled" {
  type = bool
}

# EKS
variable "cluster-version" {}
variable "endpoint-public-access" {}
variable "max_capacity_spot" {}
variable "min_capacity_spot" {}
variable "desired_capacity_spot" {}
variable "node-group-name" {}
variable "instance-types" {}
variable "ec2-ssh-key" {}



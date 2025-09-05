locals {
  org = "personal"
  env = var.env
}

module "eks" {
  source = "../modules"

  env                   = var.env
  cluster-name          = "${local.env}-${local.org}-${var.cluster-name}"
  cidr-block            = var.vpc-cidr-block
  vpc-name              = "${local.env}-${local.org}-${var.vpc-name}"
  igw-name              = "${local.env}-${local.org}-${var.igw-name}"
  pub-subnet-count      = var.pub-subnet-count
  pub-cidr-block        = var.pub-cidr-block
  pub-availability-zone = var.pub-availability-zone
  pub-sub-name          = "${local.env}-${local.org}-${var.pub-sub-name}"
  public-rt-name        = "${local.env}-${local.org}-${var.public-rt-name}"
  eks-sg                = var.eks-sg

  is_eks_role_enabled           = true
  is_eks_nodegroup_role_enabled = true
  cluster-version               = var.cluster-version
  endpoint-public-access        = true
  max_capacity_spot             = var.max_capacity_spot
  min_capacity_spot             = var.min_capacity_spot
  desired_capacity_spot         = var.desired_capacity_spot
  node-group-name               = var.node-group-name
  instance-types                = var.instance-types
  ec2-ssh-key                   = var.ec2-ssh-key
}

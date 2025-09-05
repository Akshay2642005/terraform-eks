resource "aws_eks_cluster" "eks" {
  name     = var.cluster-name
  role_arn = aws_iam_role.eks-cluster-role.arn
  version  = var.cluster-version

  vpc_config {
    subnet_ids         = aws_subnet.public-subnet[*].id
    security_group_ids = [aws_security_group.eks-cluster-sg.id]
  }
}

resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name = aws_eks_cluster.eks.name
  addon_name   = "aws-ebs-csi-driver"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = var.node-group-name
  node_role_arn   = aws_iam_role.eks-nodegroup-role.arn
  subnet_ids      = aws_subnet.public-subnet[*].id
  instance_types  = var.instance-types
  capacity_type   = "SPOT"
  scaling_config {
    max_size     = var.max_capacity_spot
    min_size     = var.min_capacity_spot
    desired_size = var.desired_capacity_spot
  }
  remote_access {
    ec2_ssh_key               = var.ec2-ssh-key
    source_security_group_ids = [aws_security_group.eks-cluster-sg.id]
  }
}

# Outputs

output "cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "cluster_security_group_id" {
  value = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
}

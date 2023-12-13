
  resource "aws_eks_cluster" "eks" {
    name     = "pc-eks"
    role_arn = aws_iam_role.demo-cluster.arn

    vpc_config {
      subnet_ids = [data.aws_subnets.public_subnets.ids[0], data.aws_subnets.public_subnets.ids[1]]
    }

    tags = {
      "Name" = "MyEKS"
    }

    depends_on = [
      aws_iam_role_policy_attachment.demo-cluster-AmazonEKSClusterPolicy,
      aws_iam_role_policy_attachment.demo-cluster-AmazonEKSServicePolicy,
      aws_iam_role_policy_attachment.demo-cluster-AmazonEKSVPCResourceController,
    ]
}

  resource "aws_eks_node_group" "node-grp" {
    cluster_name    = aws_eks_cluster.eks.name
    node_group_name = "pc-node-group"
    node_role_arn   = aws_iam_role.worker.arn
    subnet_ids      = [data.aws_subnets.public_subnets.ids[0], data.aws_subnets.public_subnets.ids[1]]
    capacity_type   = "ON_DEMAND"
    disk_size       = 20
    instance_types  = ["t2.small"]

    remote_access {
      ec2_ssh_key               = "eks-keypair"
      source_security_group_ids = [aws_security_group.allow_tls.id]
    }

    labels = {
      env = "dev"
    }

    scaling_config {
      desired_size = 2
      max_size     = 2
      min_size     = 1
    }

    update_config {
      max_unavailable = 1
    }

    depends_on = [
      aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
      aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
      aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    ]
}
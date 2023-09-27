locals {
    cluster_name = "eks-cluster"
}

provider "kubernetes" {
    host = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token = data.aws_eks_cluster_auth.cluster.token
    #load_config_file       = false
    version                = ">= 2.10"
}

module "eks" {
    source = "terraform-aws-modules/eks/aws"
    version = "~> 19.0"
    #attach_worker_cni_policy = true
    cluster_name = local.cluster_name
    cluster_version = "1.27"

    #vpc-cni = {
    #  most_recent = true
    #}
    
    vpc_id = data.aws_vpc.eks_vpc.id
    subnet_ids               = [data.aws_subnets.public_subnets.ids[0], data.aws_subnets.public_subnets.ids[1], data.aws_subnets.public_subnets.ids[2]]
    control_plane_subnet_ids = [data.aws_subnets.public_subnets.ids[0], data.aws_subnets.public_subnets.ids[1], data.aws_subnets.public_subnets.ids[2]]
    #subnets                  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

    
    /*workers_group_defaults = {
        root_volume_type = "gp2"
    }*/
  
    /*worker_groups = [
        {
            name = "Worker-Group-1"
            instance_type = "t2.micro"
            asg_desired_capacity = 2
            additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
        },
        {
            name = "Worker-Group-2"
            instance_type = "t2.micro"
            asg_desired_capacity = 1
            additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
        },
    ]*/
}

output "test" { value = module.eks.cluster_id} 

data "aws_eks_cluster" "cluster" {
    name = module.eks.cluster_name
}
data "aws_eks_cluster_auth" "cluster" {
    name = module.eks.cluster_name
}

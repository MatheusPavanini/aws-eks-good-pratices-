data "aws_vpc" "eks_vpc" {
  filter  {
    name = "tag:Usage"
    values = ["Kubernetes"]
  }
}

data "aws_subnets" "public_subnets" {
 filter {
    name = "tag:Name"
    values = ["eks-vpc-public-us-east-1*","eks-vpc-public-us-east-2*","eks-vpc-public-us-east-3b"]
 }
}

data "aws_subnets" "private_subnets" {
 filter {
    name = "tag:Name"
    values = ["eks-vpc-public-us-east-1*","eks-vpc-public-us-east-2*","eks-vpc-public-us-east-3b"]
 }
}

#data "aws_subnet" "eks_private_vpc" {
#  id = data.aws_vpc.eks_vpc.id
#} 
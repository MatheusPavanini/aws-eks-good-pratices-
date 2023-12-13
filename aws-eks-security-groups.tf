resource "aws_security_group" "worker_group_mgmt_one" {
    name_prefix = "worker_group_mgmt_one"
    vpc_id = data.aws_vpc.eks_vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [
            "10.0.0.0/8"
        ]
    }
}
resource "aws_security_group" "worker_group_mgmt_two" {
    name_prefix = "worker_group_mgmt_two"
    vpc_id = data.aws_vpc.eks_vpc.id
 
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [
            "10.0.0.0/8"
        ]
    }
}
resource "aws_security_group" "all_worker_mgmt" {
    name_prefix = "all_worker_management"
    vpc_id = data.aws_vpc.eks_vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [
            "10.0.0.0/8"
        ]
    }
}

#Validar
resource "aws_security_group" "allow_tls" {
    name_prefix   = "allow_tls_"
    vpc_id        = data.aws_vpc.eks_vpc.id

    ingress {
      description = "TLS from VPC"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
}
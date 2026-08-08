########################################
# VPC
########################################
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "qr-vpc"
  cidr = "10.0.0.0/16"

  azs = [
    "eu-north-1a",
    "eu-north-1b"
  ]

  public_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnets = [
    "10.0.3.0/24",
    "10.0.4.0/24"
  ]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Project     = "qr-app"
    Environment = "development"
  }
}

########################################
# EKS Cluster
########################################
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "qr-cluster"
  cluster_version = "1.33"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      instance_types = ["m7i-flex.large"]

      min_size     = 1
      max_size     = 3
      desired_size = 2

      ami_type      = "AL2023_x86_64_STANDARD"
      capacity_type = "ON_DEMAND"

      tags = {
        Name = "qr-node-group"
      }
    }
  }

  tags = {
    Project     = "qr-app"
    Environment = "development"
  }
}

########################################
# Use Existing S3 Bucket
########################################
data "aws_s3_bucket" "qr_bucket" {
  bucket = "osazebuck"
}
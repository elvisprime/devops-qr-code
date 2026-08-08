########################################
# VPC Outputs
########################################

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}

########################################
# EKS Outputs
########################################

output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS Cluster API Endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_version" {
  description = "EKS Kubernetes Version"
  value       = module.eks.cluster_version
}

output "cluster_security_group_id" {
  description = "EKS Cluster Security Group ID"
  value       = module.eks.cluster_security_group_id
}

output "cluster_certificate_authority_data" {
  description = "Certificate Authority Data"
  value       = module.eks.cluster_certificate_authority_data
  sensitive   = true
}

output "eks_managed_node_groups" {
  description = "EKS Managed Node Groups"
  value       = module.eks.eks_managed_node_groups
}

########################################
# S3 Outputs
########################################

output "bucket_name" {
  description = "Existing S3 bucket name"
  value       = data.aws_s3_bucket.qr_bucket.bucket
}

output "bucket_arn" {
  description = "Existing S3 bucket ARN"
  value       = data.aws_s3_bucket.qr_bucket.arn
}
variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-north-1"
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
  default     = "qr-cluster"
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "qr-vpc"
}

variable "bucket_name" {
  description = "S3 Bucket Name"
  type        = string
  default     = "aimufuabuck"
}
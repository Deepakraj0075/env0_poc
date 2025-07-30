
# # ---------CREATING S3 DATA BUCKET  --------------
# resource "aws_s3_bucket" "thiss3" {
#   # bucket = "${var.env}-${var.region}-${var.bucket_name}-logs"
#   bucket = "dev-us-east-1-warrior-0751raj-logs"
#   tags = {
#     # Name            = "${var.env}-${var.bucket_name}"
#     Name            = "warrior-0751raj"
#     # Environment     = var.env
#     Environment     = "dev"
#     Managed_by      = "Terraform"
#   }
# }

# # ------------------ RESTRICTING PUBLIC ACCESS FOR THE DATA BUCKET / versioning enabled--------------------
# resource "aws_s3_bucket_public_access_block" "block_public_access_data" {
#   bucket                  = aws_s3_bucket.thiss3.id
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true //
# }
# resource "aws_s3_bucket_versioning" "s3_data_bucket_versioning" {
#   bucket = aws_s3_bucket.thiss3.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.3"
}

# ------------------- AWS PROVIDER BLOCK ----------------------
provider "aws" {
  region  = "us-east-1"
  # Optionally, specify your AWS CLI profile if not using default:
  # profile = "default"
  # Or supply credentials with environment variables if not using profile
}


# ------------------- EC2 INSTANCE ---------------------
resource "aws_instance" "poc_demo_env_server" {
  ami           = "ami-01edd5711cfe3825c" 
  instance_type = "t2.micro"
  tags = {
    Name = "poc-demo-env-server"
  }
}

# ---------CREATING S3 DATA BUCKET --------------
resource "aws_s3_bucket" "thiss3" {
  bucket = "dev-us-east-1-warrior-0751raj"
  tags = {
    Name         = "warrior-0751raj"
    Environment  = "dev"
    Managed_by   = "Terraform"
  }
}

# ------------------ RESTRICTING PUBLIC ACCESS FOR THE DATA BUCKET / versioning enabled--------------------
resource "aws_s3_bucket_public_access_block" "block_public_access_data" {
  bucket                   = aws_s3_bucket.thiss3.id
  block_public_acls        = true
  block_public_policy      = true
  ignore_public_acls       = true
  restrict_public_buckets  = true
}

resource "aws_s3_bucket_versioning" "s3_data_bucket_versioning" {
  bucket = aws_s3_bucket.thiss3.id
  versioning_configuration {
    status = "Enabled"
  }
}

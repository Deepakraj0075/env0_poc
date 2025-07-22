
# ---------CREATING S3 DATA BUCKET  --------------
resource "aws_s3_bucket" "thiss3" {
  # bucket = "${var.env}-${var.region}-${var.bucket_name}-logs"
  bucket = "dev-us-east-1-warrior-0751raj-logs"
  tags = {
    # Name            = "${var.env}-${var.bucket_name}"
    Name            = "warrior-0751raj"
    # Environment     = var.env
    Environment     = "dev"
    Managed_by      = "Terraform"
  }
}

# ------------------ RESTRICTING PUBLIC ACCESS FOR THE DATA BUCKET / versioning enabled--------------------
resource "aws_s3_bucket_public_access_block" "block_public_access_data" {
  bucket                  = aws_s3_bucket.thiss3.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_s3_bucket_versioning" "s3_data_bucket_versioning" {
  bucket = aws_s3_bucket.thiss3.id
  versioning_configuration {
    status = "Enabled"
  }
}
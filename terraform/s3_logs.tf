# Create S3 bucket
resource "aws_s3_bucket" "epm_s3_bucket" {
    bucket = var.log_bucket_name
}
# Enabling bucket versioning
resource "aws_s3_bucket_versioning" "epm_s3_bucket_versioning" {
    bucket = aws_s3_bucket.epm_s3_bucket.id
    versioning_configuration {
      status = "Enabled"
    }
}
# Set Default encryption: SSE-S3 (AES256) enabled
resource "aws_s3_bucket_server_side_encryption_configuration" "epm_s3_bucket_ss_encryption_config" {
    bucket = aws_s3_bucket.epm_s3_bucket.id

    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
}
# S3 bucket blocking public access
resource "aws_s3_bucket_public_access_block" "epm_s3_bucket_block_public_access" {
    bucket = aws_s3_bucket.epm_s3_bucket.id

    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}
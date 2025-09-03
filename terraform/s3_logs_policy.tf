# S3 bucket policy that allows CloudTrail to write
resource "aws_s3_bucket_policy" "allow_cloudtrail_write" {
  bucket = aws_s3_bucket.epm_s3_bucket.id  

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      # 1) CloudTrail must read the bucket ACL
      {
        Sid       = "AllowCloudTrailToGetBucketAcl",
        Effect    = "Allow",
        Principal = { Service = "cloudtrail.amazonaws.com" },
        Action    = "s3:GetBucketAcl",
        Resource  = "arn:aws:s3:::${aws_s3_bucket.epm_s3_bucket.bucket}"
      },

      # 2) CloudTrail must be able to PUT(write objects) objects under the exact AWSLogs/<account-id>/ prefix path
      {
        Sid       = "AllowCloudTrailToPutObject",
        Effect    = "Allow",
        Principal = { Service = "cloudtrail.amazonaws.com" },
        Action    = "s3:PutObject",
        Resource  = "arn:aws:s3:::${aws_s3_bucket.epm_s3_bucket.bucket}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
      }
    ]
  })
}
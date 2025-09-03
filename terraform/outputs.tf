output "log_bucket_name" {
    description = "Name of the S3 bucket storing CloudTrail logs"
    value = aws_s3_bucket.epm_s3_bucket.bucket
}

output "cloudtrail_trail_arn" {
    description = "ARN of the CloudTrail trail"
    value = aws_cloudtrail.epm_ct.arn
}

output "aws_guardduty_detector_id" {
    description = "ID of the GuardDuty detector"
    value = aws_guardduty_detector.epm_detector.id
}
# AWS Region Variable
variable "aws_region" {
    description = "Describes the region in which AWS resources are being implemented."
    type = string
    default = "us-east-1"
}
# S3 Log Bucket Names
variable "log_bucket_name" {
    description = "S3 bucket where CloudTrail delivers logs."
    type = string
    default = "epm-mini-secops-logs"
}
# Cloudtrail var
variable "trail_name" {
    description = "name of cloudtrail"
    type = string
    default = "mini-secops-trail"
}
# Enable S3 Data events
variable "enable_s3_data_events" {
    description = "Controls whether CloudTrail records object-level S3 events."
    type = bool
    default = false
}
# Creating CloudTrail on a single region trail
resource "aws_cloudtrail" "epm_ct" {
    name = var.trail_name
    s3_bucket_name = aws_s3_bucket.epm_s3_bucket.id
    include_global_service_events = true
    is_multi_region_trail = false
    is_organization_trail = false
    enable_logging = true

    # Explicitly captures management events 
    event_selector {
      read_write_type = "All"
      include_management_events = true
    }
    # A way to conditionally add or repeat nested blocks. it’s used to only include an event_selector if your variable enable_s3_data_events is set to true.
    dynamic "event_selector" {
      for_each = var.enable_s3_data_events ? [1] : [] # If enable_s3_data_events = true, Terraform loops over [1] (a list with one element), so it creates one event_selector block. If enable_s3_data_events = false, it loops over [] (an empty list), so it creates zero event_selector blocks.
      content {
        read_write_type = "All"
        include_management_events = false # This means: record both read and write data events, but not management events (since those are already captured by the earlier selector).

        data_resource {
          type = "AWS::s3::Object" # says “this selector applies to S3 object-level events.”
          # The trailing slash means "all objects in this bucket"
          values = ["arn:aws:s3:::${aws_s3_bucket.epm_s3_bucket.bucket}/"] # the / means capture events for all objects inside the bucket. Without the / you'd be pointing at the bucket itself, cloudtrail wont accept for object level logging. 
        }
      } 
    }
    # This ensures that bucket policy grants CloudTrail write access.advanced_event_selector. depends_on makes Terraform wait until the bucket policy is applied before it creates the CloudTrail resource. That way, when CloudTrail tries to write its first logs, the S3 bucket already trusts it.
      depends_on = [aws_s3_bucket_policy.allow_cloudtrail_write]
    }

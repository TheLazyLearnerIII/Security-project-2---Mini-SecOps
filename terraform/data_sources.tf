data "aws_caller_identity" "current" {}

# This means who am I authenticated as right now.
# and returns 3 useful pieces of info about your current AWS identity:
        # data.aws_caller_identity.current.account_id → your 12-digit AWS account ID
        # data.aws_caller_identity.current.user_id → the ARN-style ID of the user/role you’re using
        # data.aws_caller_identity.current.arn → the full ARN of the caller (like arn:aws:iam::123456789012:user/JohnDoe)
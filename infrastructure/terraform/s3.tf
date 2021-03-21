# terraform/s3.tf
# testing things out a bit

resource "aws_s3_bucket" "home" {
  bucket = var.domain_name
  policy = data.aws_iam_policy_document.web_policy.json

  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket       = aws_s3_bucket.home.bucket
  key          = "index.html"
  source       = "../../index.html"
  content_type = "text/html"

  etag         = filemd5("../../index.html")
}


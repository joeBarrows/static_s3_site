# testing things out a bit

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "home" {
  bucket = "s3-website-test.joe.com"
  acl    = "public-read"
  #policy = file("policy.json")

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
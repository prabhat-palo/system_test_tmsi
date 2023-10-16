terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "my-tf-log-bucket"
  acl = "log-delivery-write"
}
resource "aws_s3_bucket" "foo" {
  acl = "public-read-write"

  bucket = "foo_name"
  versioning {
    enabled = false
  }
  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }
}
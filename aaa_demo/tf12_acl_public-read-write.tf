terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "my-tf-log-bucket"
  acl = "log-delivery-write"
  tags = {
    Demo = "log-delivery-write"
  }
}

resource "aws_s3_bucket_versioning" "log_bucket" {
  bucket = aws_s3_bucket.log_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "log_bucket_destination" {
  # checkov:skip=CKV_AWS_144:the resource is auto generated to be a destination for replication
  bucket = aws_s3_bucket.log_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_iam_role" "log_bucket_replication" {
  name = "aws-iam-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_replication_configuration" "log_bucket" {
  depends_on = [aws_s3_bucket_versioning.log_bucket]
  role   = aws_iam_role.log_bucket_replication.arn
  bucket = aws_s3_bucket.log_bucket.id
  rule {
    id = "foobar"
    status = "Enabled"
    destination {
      bucket        = aws_s3_bucket.log_bucket_destination.arn
      storage_class = "STANDARD"
    }
  }
}
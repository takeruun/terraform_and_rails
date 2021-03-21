variable "s3_bucket_name" {
  default = "terraform-and-rails-remote-state"
}

resource "aws_s3_bucket" "terraform-and-rails-remote-state" {
  bucket = var.s3_bucket_name

  lifecycle {
    prevent_destroy = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Terraform = "true"
    Name      = "terraform_and_rails"
  }
}

resource "aws_dynamodb_table" "terraform-and-rails-state-lock" {
  name         = "terraform-and-rails-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Terraform = "true"
    Name      = "terraform_and_rails"
  }
}

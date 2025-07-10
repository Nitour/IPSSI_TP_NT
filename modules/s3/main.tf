resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "tp-s3-nt-${random_string.suffix.result}"

  tags = {
    Project     = "TP-Terraform"
    ManagedBy   = "Terraform"
    Environment = var.environment
  }

  /* 
# Prévention contre la suppression (: un terraform destroy)
# Ici, je le laisse commenté pour que je puisse détruire sans problème étant donné que j'ai aucune données dedans 
  lifecycle {
    prevent_destroy = true
  }
  */
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# BONUS (optionnel) – Blocage de l’accès public
resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

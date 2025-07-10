output "bucket_name" {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "Nom du bucket S3 créé pour le TP"
}

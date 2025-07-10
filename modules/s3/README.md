Ce module crée un bucket S3 sécurisé, utilisé pour stocker des fichiers liés au projet Terraform (états ou autres fichiers nécessaires au TP).

## Ressources créées

- `aws_s3_bucket.terraform_state` : Bucket S3 avec un nom unique généré automatiquement
- `aws_s3_bucket_server_side_encryption_configuration` : Chiffrement AES-256 activé par défaut
- `aws_s3_bucket_public_access_block` : Blocage complet de l'accès public (option bonus activé par défaut)

## Variables 

- `environment` : Nom de l’environnement (ex: `"dev"`), utilisé dans les tags du bucket

## Outputs

- `bucket_name` : Nom final du bucket S3 créé
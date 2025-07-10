Déploiement de plusieurs serveurs web EC2 avec Nginx pré configurés avec un script permettant d'afficher son propre ID sur la page d'accueil.

## Ressources créées

- `aws_instance.ec2_web` : Instances EC2 configurées avec Nginx et un message d’identification.

## Variables attendues

- `ami_filter` : Filtres pour rechercher dynamiquement l’AMI (Ubuntu/Debian, architecture, owner)
- `key_pair_name` : Nom de la paire de clés SSH à utiliser
- `instance_count` : Nombre d'instances à déployer (par défaut : 2)
- `instance_type` : Type d'instance EC2 (par défaut : `t2.micro`)
- `subnet_ids` : Liste des subnets dans lesquels déployer les instances (répartition automatique)
- `security_group_id` : ID du Security Group à appliquer

## Outputs

- `web_instance_ids` : Liste des IDs des instances EC2
- `web_public_ips` : Liste des adresses IP publiques
- `instance_details` : Détail de chaque instance (ID, IPs, nom)
- `public_urls` : URLs d’accès HTTP aux instances web


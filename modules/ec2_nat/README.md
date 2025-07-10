Ce module déploie une instance EC2 NAT Debian permettant aux instances privées d'accéder à Internet.



## Ressources créées

- `aws_instance.nat` : Instance EC2 configurée pour faire office de NAT

## Variables

- `enable_nat_instance` : Booléen pour activer ou non la création de l’instance NAT
- `subnet_id` : ID du subnet public où sera lancée l’instance NAT
- `sg_id` : ID du Security Group à appliquer à l’instance NAT
- `key_pair_name` : Nom de la clé SSH à utiliser pour l’accès
- `ami_filter` : Filtres pour récupérer dynamiquement l'AMI (type, owner, architecture)

## Outputs

- `nat_instance_id` : ID de l’instance NAT
- `nat_network_interface_id` : ID de l’interface réseau principale de l’instance NAT
- `nat_public_ip` : Adresse IP publique de l’instance NAT
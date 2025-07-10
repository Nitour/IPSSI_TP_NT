Ce module permet de créer une infrastructure réseau complète sur AWS

Il crée :
- Un VPC principal
- Un Internet Gateway
- Trois types de subnets : publics, privés, database
- Une table de routage publique et une privée
- Les associations entre les subnets et les tables de routage

## Variables

- `vpc_cidr` : CIDR block principal du VPC
- `availability_zones` : Liste des zones de disponibilité à utiliser
- `public_subnet_cidrs` : CIDR blocks pour les subnets publics
- `private_subnet_cidrs` : CIDR blocks pour les subnets privés
- `database_subnet_cidrs` : CIDR blocks pour les subnets de base de données
- `nat_instance_id` : ID de l'instance NAT (optionnel, utilisé pour la route)
- `nat_network_interface_id` : ID de l'interface réseau NAT (utilisé dans la table de routage privée)

## Outputs exposés

- `vpc_id` : ID du VPC créé
- `vpc_cidr` : CIDR utilisé pour le VPC
- `public_subnet_ids` : Liste des IDs des subnets publics
- `private_subnet_ids` : Liste des IDs des subnets privés
- `database_subnet_ids` : Liste des IDs des subnets pour la base de données

## Remarques

- La route privée utilise `network_interface_id` pour diriger le trafic sortant via l'instance NAT.
- Le module est compatible avec un équilibrage de charge, des EC2 publics/privés, et une base de données isolée.

Ce module crée trois groupes de sécurité (Security Groups) pour les différentes ressources du projet

## Groupes créés

1. NAT Security Group (`nat_sg`)
   - Autorise le trafic SSH (port 22) uniquement depuis l'adresse IP publique du poste local
   - Autorise tout le trafic sortant

2. Web Security Group (`web_sg`) 
   - Autorise le trafic HTTP (port 80) depuis Internet
   - Autorise le SSH uniquement depuis l'adresse IP publique du poste local
   - Tout trafic sortant est autorisé

3. ALB Security Group (`alb_sg`)  
   - Autorise le trafic HTTP (port 80) depuis Internet vers le Load Balancer
   - Autorise tout le trafic sortant

## Variables 

- `vpc_id` *(string)* : ID du VPC dans lequel seront créés les Security Groups

## Outputs

- `nat_sg_id` : ID du SG utilisé par l’instance NAT
- `web_sg_id` : ID du SG utilisé par les instances web
- `alb_sg_id` : ID du SG utilisé par l’équilibreur de charge (ALB)

## Fonctionnalités techniques

- Utilise la **data source `http`** pour détecter automatiquement l'IP publique
- Configuration des règles de sécurité strictes selon le rôle du composant
- Bonnes pratiques AWS respectées (SSH limité, ALB ouvert uniquement sur HTTP)

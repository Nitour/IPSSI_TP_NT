Ce module crée un équilibreur de charge de type ALB pour répartir le trafic HTTP entre plusieurs instances EC2.
Si l'une tombe en panne, alors l'autre instance peut prendre le relai. 

## Ressources créées

- `aws_lb` : Application Load Balancer (ALB)
- `aws_lb_target_group` : Groupe de cibles pour les instances EC2
- `aws_lb_listener` : Listener sur le port 80 pour diriger le trafic vers le groupe cible

## Variables

- `vpc_id` : ID du VPC dans lequel déployer l’ALB
- `subnet_ids` : Liste des subnet publics où placer l’ALB
- `alb_sg_id` : ID du Security Group à associer à l’ALB
- `web_instance_ids` : Liste des ID des instances EC2 web à enregistrer dans le groupe de cibles

## Outputs

- `alb_dns_name` : Nom DNS public de l’ALB
# Infrastructure Cloud - Projet Terraform Complet

Ce projet déploie une infrastructure complète sur AWS à l’aide de Terraform. L’architecture inclut un VPC, des subnets, des instances EC2 (NAT + serveurs web), un bucket S3, un équilibreur de charge (ALB), et les groupes de sécurité associés.

---

## Architecture (schéma simplifié)

```
                      +-------------------+
                      |    Internet       |
                      +--------+----------+
                               |
                          +----v----+
                          |  ALB    |  <-- Load Balancer public
                          +----+----+
                               |
               +---------------+---------------+
               |                               |
        +------v------+                 +------v------+
        |  EC2 Web 1  |                 |  EC2 Web 2  |
        +-------------+                 +-------------+

    Subnets publics avec accès HTTP/SSH

                      +--------------------+
                      |   EC2 NAT Instance |
                      +--------+-----------+
                               |
                       Subnet public NAT
                               |
                    +----------v-----------+
                    |   Subnets privés     |
                    +----------------------+

                      +--------------------+
                      | S3 (state backend) |
                      +--------------------+

                      +--------------------+
                      | VPC (CIDR, AZs)    |
                      +--------------------+
```

---

## Étapes réalisées

### 1. Création du bucket S3
- Bucket nommé dynamiquement via `random_string`
- Chiffrement SSE AES256 activé
- Blocage de l’accès public activé
- Tags : `Project`, `ManagedBy`, `Environment`
- Output : nom du bucket affiché dans les outputs root

### 2. Module VPC
- CIDR configuré via `.tfvars`
- 2 subnets publics, 2 privés, 2 subnets DB dans 2 AZs
- Internet Gateway et tables de routage
- Public subnets avec IP publique automatique
- Tags standardisés

### 3. Séparation claire des variables
- `variables.tf` pour la déclaration
- `terraform.tfvars` pour la configuration
- Aucun doublon ni variable manquante

### 4. Déploiement Git
- Repo Git initialisé
- `.gitignore` configuré (empêche versioning des credentials ou state)

### 5. Instances EC2
- Module EC2 Web : 2 serveurs Nginx avec affichage de l’ID d’instance
- Module EC2 NAT : pour routage des subnets privés
- Sélection de l'AMI configurée au niveau root

### 6. ALB
- ALB HTTP public configuré
- Enregistre automatiquement les instances EC2 Web
- DNS de l’ALB exposé dans les outputs

### 7. Résumé final
- Output `infrastructure_summary` complet avec VPC, S3, EC2, IPs, URLs

---

## Prérequis

- Un compte AWS avec un profil IAM configuré localement
- Un fichier `.aws/credentials` valide (ou AWS CLI configurée)
- Terraform CLI ≥ 1.1.0
- Clé SSH nommée `terraform` existante dans AWS (console EC2 > Key pairs)

---

## Déploiement (pas à pas)

1. Clonez le repo
   ```bash
   git clone <URL_DU_REPO>
   cd <projet>
   ```

2. Modifiez les fichiers si besoin :
   - `terraform.tfvars` pour ajuster CIDR, AZs, etc.
   - Vérifiez que `key_pair_name` = `"terraform"`

3. Initialisez Terraform
   ```bash
   terraform init
   ```

4. Planifiez le déploiement
   ```bash
   terraform plan
   ```

5. Appliquez
   ```bash
   terraform apply
   ```

6. Visualisez les outputs :
   - IP publique de la NAT
   - URLs des serveurs Web
   - DNS de l’ALB
   - Résumé complet (`infrastructure_summary`)

---

## Troubleshooting

| Problème | Solution |
|---------|----------|
| **Erreur `body` deprecated dans le SG** | Utiliser `response_body` à la place de `body` |
| **Pas d’autorisation pour `ec2:DescribeImages`** | Vérifier la policy IAM de l’utilisateur Terraform |
| **Erreur `Unsupported argument` dans un module** | Vérifiez que les outputs/variables sont bien exportés depuis les sous-modules |
| **Clé SSH non trouvée** | Créez une clé nommée `terraform` via AWS EC2 > Key Pairs |
| **Problème avec les `outputs`** | Vérifiez que tous les modules ont bien des `outputs.tf` avec les bonnes valeurs exportées |

---

## Structure du projet

```
.
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── provider.tf
└── modules/
    ├── vpc/
    ├── s3/
    ├── sg/
    ├── ec2_nat/
    ├── ec2_web/
    └── alb/
```

# Infrastructure Terraform – Root Module

ctte partie gère déploiement complet de l'infrastructure via plusieurs modules réutilisables. Chaque module est défini dans un sous-répertoire et est appelé depuis le fichier `main.tf`.

## Modules inclus

- VPC : Crée un VPC avec des subnets publics, privés et database + routage
- SG (Security Groups) : Définit les groupes de sécurité pour le NAT, les serveurs web et l’ALB
- S3 : Provisionne un bucket S3 avec chiffrement et blocage d’accès public
- EC2 NAT : Lance une instance NAT pour le routage sortant des subnets privés
- EC2 Web : Déploie 2 serveurs web avec Nginx et un affichage personnalisé (ID d’instance)
- ALB (Application Load Balancer)** : Configure un load balancer HTTP pointant vers les instances web

## Variables à définir (via `terraform.tfvars`) (je l'indique ici car il est caché dans le github)

```
vpc_cidr             = "10.0.0.0/16"
availability_zones   = ["us-east-1a", "us-east-1b"]

public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
database_subnet_cidrs = ["10.0.21.0/24", "10.0.22.0/24"]

enable_nat_instance = true
environment         = "dev"

ami_filter = {
  name_pattern = "debian-11-amd64-*"
  owners       = ["136693071363"]
  architecture = "x86_64"
}
```

## Outputs principaux

- `nat_instance_public_ip` : IP publique de l’instance NAT
- `alb_url` : DNS public du Load Balancer HTTP
- `infrastructure_summary` : Résumé complet de l’infra :
  - VPC ID et CIDR
  - Nom du bucket S3
  - Détails des instances web (ID, IPs, nom)
  - URLs d’accès HTTP aux serveurs web
  - IP publique de la NAT

## Fournisseur

Déclaré dans `provider.tf` :
```
provider "aws" {
  region                  = "us-east-1"
  shared_credentials_files = [".aws/credentials"]
  profile                 = "default"
}
```

Chaque module est documenté individuellement dans son propre `README.md`, voir les répertoires `modules/*`.

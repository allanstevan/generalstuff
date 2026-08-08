# Esqueleto Terraform — tags e variáveis de ambiente.
# Preencher backend/provider conforme PRODAM ou cloud aprovada.
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    # null provider só para validar o esqueleto sem credenciais
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}

variable "environment" {
  type        = string
  description = "dev | hml | prd"
  validation {
    condition     = contains(["dev", "hml", "prd"], var.environment)
    error_message = "environment must be dev, hml or prd."
  }
}

variable "project" {
  type    = string
  default = "bolsa-atleta"
}

locals {
  tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
    Contract    = "043/SEME/2026"
    OS          = "03"
  }
}

resource "null_resource" "bootstrap_marker" {
  triggers = {
    env = var.environment
  }
  provisioner "local-exec" {
    command = "echo Bootstrap IaC for ${var.project}/${var.environment}"
  }
}

output "tags" {
  value = local.tags
}

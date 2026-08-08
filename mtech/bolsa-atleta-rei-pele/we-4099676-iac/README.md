# IaC — Bolsa Atleta (DEV / HML)

Task WorkExtra **#4099676**. Laudo: `IaC_Manifests_Dev_Homolog_v1.html` (nesta pasta no GitHub / `../` no mtech).

**GitHub:** https://github.com/allanstevan/generalstuff/tree/main/mtech/bolsa-atleta-rei-pele/we-4099676-iac  

**M-TECH (auth):** https://corp.skyline.lat/mtech/4099676/

## Compose

```bash
cp .env.example .env
# editar senhas
docker compose -f docker-compose.dev.yml config
# docker compose -f docker-compose.dev.yml up -d   # quando imagens existirem
```

HML: use `docker-compose.hml.yml` + `.env.hml` (Postgres sem bind na host).

## Kubernetes

```bash
kubectl apply -f k8s/namespace-dev.yaml
kubectl apply -f k8s/namespace-hml.yaml
# kubectl apply -f k8s/deploy-web-api-sample.yaml  # após criar secret bolsa-api-secrets
```

## Terraform

```bash
cd terraform
terraform init
terraform plan -var="environment=dev"
```

## Segurança

- Não commitar `.env` com segredos.
- Pipeline (#8312452): build → Trivy/Gitleaks → deploy por ambiente.
- Produção/PRODAM: ajustar storage class, ingress e rede com a CMU.

# Enterprise — Wizard pour les grandes organisations

## Quand activer ce module

Activer si le projet répond à ≥ 2 de ces critères :
- Équipe > 10 développeurs
- Données clients en production (RGPD, HIPAA, SOC2)
- Utilisateurs > 10 000
- Budget infrastructure > 1000€/mois
- Client = grande entreprise / institution publique

---

## Ce qui manque dans Wizard Standard (gaps enterprise)

### 🔴 Critique (bloquant pour une grande org)

| Gap | Problème | Solution |
|-----|----------|----------|
| **SSO / SAML** | Pas d'auth enterprise | Clerk Enterprise / Auth0 / Azure AD SAML |
| **Audit trail complet** | Pas de traçabilité | Toutes actions loggées avec user + timestamp + IP |
| **RBAC multi-niveaux** | Permissions trop plates | Rôles : super_admin / org_admin / team_lead / developer / viewer |
| **Multi-tenant isolé** | Données mélangées | Schema-per-tenant OU database-per-tenant |
| **SLA contractuels** | Pas de garantie uptime | Architecture 99.9% → load balancer + multi-zone + health checks |
| **Secrets management** | .env insuffisant | HashiCorp Vault OU AWS Secrets Manager OU Azure Key Vault |

### 🟡 Important (recommandé enterprise)

| Gap | Problème | Solution |
|-----|----------|----------|
| **Approval workflows** | Déploiement sans validation | PR obligatoire + review senior + staging gate |
| **Compliance modules** | Pas RGPD/HIPAA formalisé | Documentation compliance + DPA (Data Processing Agreement) |
| **Incident management** | Pas de process crise | Runbooks + escalation matrix + post-mortem template |
| **Cost governance** | Budget cloud non maîtrisé | Tags par équipe/projet + alertes budget + FinOps dashboard |
| **Dependency management** | Vulnérabilités passées | Dependabot + Snyk + policy "no critical CVE en prod" |
| **Data residency** | Données hors pays | Choix région hébergement + contractualisation DPA |

---

## Architecture Enterprise recommandée

### Tier 1 — Infrastructure (fondations)

```
┌─────────────────────────────────────────────────────────┐
│                    Cloudflare (CDN + WAF + DDoS)         │
└─────────────────────────┬───────────────────────────────┘
                          │
┌─────────────────────────▼───────────────────────────────┐
│              Load Balancer (Cloudflare / AWS ALB)        │
└──────────┬──────────────────────────────┬───────────────┘
           │                              │
    ┌──────▼──────┐                ┌──────▼──────┐
    │  App Zone A │                │  App Zone B │
    │  (primary)  │                │  (failover) │
    └─────────────┘                └─────────────┘
           │                              │
    ┌──────▼──────────────────────────────▼──────┐
    │         Database Cluster (Primary + Replica) │
    │         + Read replicas pour analytics       │
    └─────────────────────────────────────────────┘
```

### Tier 2 — Sécurité enterprise

```
Auth Flow :
  Utilisateur → SSO/SAML (Azure AD / Okta / Google Workspace)
             → Token JWT signé (RS256 — clé asymétrique)
             → Session Redis (TTL court : 1h)
             → Refresh via cookie httpOnly SameSite=Strict

Secrets :
  Local dev → .env.local
  CI/CD     → GitHub Actions Secrets OU Vault dynamic secrets
  Production → Vault / AWS SSM Parameter Store / Azure Key Vault
  JAMAIS en dur → git-secrets hook bloque le commit

Network :
  Tout le trafic interne en mTLS (mutual TLS)
  Zero Trust Network Access (ZTNA) pour l'accès admin
  VPN obligatoire pour les accès DB directs
```

### Tier 3 — Observabilité enterprise

```
Logs      → Structured JSON (Pino / Winston) → Datadog / ELK Stack
Traces    → OpenTelemetry → Jaeger / Datadog APM
Metrics   → Prometheus → Grafana (dashboards par équipe)
Alerting  → PagerDuty / Opsgenie (escalation matrix)
Errors    → Sentry (avec alerting Slack + PagerDuty)
Uptime    → Pingdom / StatusPage.io (page status publique)
```

---

## GitHub Flow enterprise

```
Branches obligatoires :
  main (protégée, déploiement prod)
    └── staging (auto-deploy staging)
          └── develop (intégration continue)
                └── feature/[JIRA-123]-description
                └── bugfix/[JIRA-456]-description
                └── hotfix/[JIRA-789]-description (→ main directement)

Règles de protection sur `main` :
  - 2 reviewers minimum (dont 1 senior)
  - CI/CD obligatoire (lint + tests + security scan)
  - Branch à jour avec main
  - Signed commits recommandés

Environnements :
  dev (auto-deploy sur chaque PR)
  staging (auto-deploy sur develop)
  production (deploy manuel avec approbation)
```

---

## Checklist conformité enterprise

### RGPD (EU) — Obligatoire si utilisateurs européens

- [ ] **DPO désigné** (Data Protection Officer) ou contact RGPD
- [ ] **Registre des traitements** documenté (Art. 30 RGPD)
- [ ] **Consentement explicite** — opt-in, pas pre-checked
- [ ] **Droit à l'oubli** — endpoint de suppression complète (cascade)
- [ ] **Portabilité** — export JSON/CSV des données utilisateur
- [ ] **Privacy by Design** — pas de collecte de données inutiles
- [ ] **Data breach notification** — process < 72h pour notifier la CNIL
- [ ] **DPA signé** avec chaque sous-traitant (Supabase, Vercel, etc.)
- [ ] **Cookies compliance** — Axeptio / Cookiebot / OneTrust
- [ ] **Chiffrement au repos** — colonnes sensibles (AES-256)
- [ ] **Audit log** — chaque accès aux données personnelles tracé

### SOC 2 (si clients US enterprise)

- [ ] Contrôles d'accès documentés et reviewés annuellement
- [ ] Vulnerability scanning mensuel (Snyk + npm audit)
- [ ] Penetration testing annuel (externe)
- [ ] Disaster Recovery Plan testé (RTO < 4h, RPO < 1h)
- [ ] Employee security training (phishing, data handling)
- [ ] Vendor risk assessment pour chaque outil tiers

---

## Incident Management — Runbook template

```
INCIDENT SEVERITY
  P1 (Critique) : Production down, données exposées → PagerDuty immédiat
  P2 (Majeur)   : Feature dégradée > 30% utilisateurs → Alerte équipe
  P3 (Mineur)   : Bug isolé, workaround possible → Ticket JIRA P2

ESCALATION MATRIX
  P1 → Lead dev (5 min) → CTO (15 min) → CEO si data breach (30 min)
  P2 → Lead dev (30 min) → Manager (2h)
  P3 → Dev assigné (24h)

POST-MORTEM TEMPLATE
  1. Timeline précise de l'incident
  2. Root cause (pas "erreur humaine" — systémique toujours)
  3. Impact (users affectés, data perdue, SLA breach)
  4. Actions correctives (avec owner + deadline)
  5. Actions préventives (pour éviter la récurrence)
  Partager en interne sous 48h après résolution
```

---

## Stack enterprise recommandée (2025)

| Catégorie | Solo/Startup | Enterprise |
|-----------|-------------|------------|
| Auth | Clerk / Supabase Auth | Auth0 / Azure AD / Okta |
| Secrets | .env + Vercel env | HashiCorp Vault / AWS SSM |
| Monitoring | Sentry | Datadog / New Relic |
| Logs | Console + Sentry | ELK Stack / Datadog Logs |
| CI/CD | GitHub Actions | GitHub Actions + ArgoCD |
| Hosting | Vercel / Railway | AWS / Azure / GCP (multi-zone) |
| DB | Supabase | RDS Aurora / Azure SQL (avec replicas) |
| CDN | Vercel Edge | Cloudflare Enterprise |
| Search | PostgreSQL FTS | Elasticsearch / Typesense |
| Queue | Inngest / Trigger.dev | AWS SQS / Azure Service Bus |

---

## Ce que Coca-Cola / Microsoft exigerait en plus

1. **On-premise / Private Cloud** — données JAMAIS chez un SaaS tiers non audité
2. **Custom SLA** — 99.99% uptime contractuel avec pénalités financières
3. **Penetration testing** — audit externe annuel obligatoire (certifié OSCP)
4. **ISO 27001 / SOC 2 Type II** — certifications requises pour tous les vendors
5. **Change Management** — aucun déploiement sans Change Advisory Board (CAB)
6. **Enterprise Support** — hotline 24/7 avec temps de réponse garantis contractuellement
7. **Data sovereignty** — hébergement dans le pays de l'utilisateur (RGPD + CLOUD Act)
8. **Integration middleware** — connecteurs ERP (SAP, Oracle), CRM (Salesforce), ITSM (ServiceNow)
9. **LDAP / Active Directory** — synchronisation annuaire entreprise
10. **Immutable audit log** — logs signés cryptographiquement, impossibles à modifier

---

## Commande `wizard enterprise`

Quand l'utilisateur tape "wizard enterprise" ou qu'un projet enterprise est détecté :

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🏢 WIZARD — Mode Enterprise activé

Niveau détecté : [startup / mid-market / enterprise / big-corp]

🔴 BLOQUANTS avant prod :
→ [liste des gaps critiques]

🟡 À planifier (S+1) :
→ [liste des recommandations importantes]

📋 Stack enterprise recommandée :
→ Auth : [choix]
→ Secrets : [choix]
→ Monitoring : [choix]
→ Compliance : [niveau RGPD/SOC2]

💰 Budget infrastructure estimé : [X€/mois]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

# Deploy Guide — Déploiement multi-plateformes

## Principe

Adapter la plateforme selon la stack, le budget, et les besoins.
Utiliser web search pour vérifier les pricing actuels avant de recommander.

---

## Checklist pré-déploiement universelle

### Checks automatiques (mode CLI) :

```bash
# 1. Build de production
npm run build 2>&1 || echo "BUILD FAILED — arrêter ici"

# 2. Tests passent
npm test 2>&1 | tail -5

# 3. Lister toutes les variables d'env nécessaires
grep -rhoP '(?:process\.env\.)\K[A-Z_]+' \
  --include="*.ts" --include="*.js" \
  --exclude-dir=node_modules | sort -u
# Comparer avec .env.example

# 4. Pas de secrets API en dur
grep -rn "sk_live\|pk_live\|AKIA\|ghp_\|xoxb-\|Bearer " \
  --include="*.ts" --include="*.js" \
  --exclude-dir=node_modules --exclude-dir=.git

# 5. .env.example existe et est à jour
test -f .env.example && echo "OK" || echo "MANQUANT: créer .env.example"

# 6. .env dans .gitignore
grep -q ".env" .gitignore && echo "OK" || echo "CRITIQUE: .env non ignoré"
```

### Checklist manuelle :

- [ ] Toutes les variables d'env configurées sur la plateforme
- [ ] `.env` JAMAIS dans le repo
- [ ] `.env.example` à jour (clés sans valeurs)
- [ ] Build de production testé localement
- [ ] Base de données migrée
- [ ] DNS configuré (si domaine custom)
- [ ] HTTPS activé
- [ ] Monitoring d'erreurs en place (Sentry recommandé)
- [ ] Rollback plan défini

---

## Guides par plateforme

### Vercel (Next.js / React / Astro / frontend)

```
1. vercel.com → New Project → Import Git Repository
2. Framework auto-détecté (vérifier le build command)
3. Environment Variables :
   → Ajouter chaque variable de .env.example
   → Choisir les environnements (Production / Preview / Development)
4. Deploy → automatique à chaque push sur main
5. Domaine custom : Settings → Domains → Add Domain
```

**Points d'attention :**
- Free tier : 100GB bandwidth/mois — suffisant pour démarrer
- Serverless functions : cold starts de ~100-500ms
- Edge middleware : ultra-rapide pour redirections/auth
- Analytics inclus gratuitement

---

### Supabase (BaaS — DB + Auth + Storage + Realtime)

```
1. supabase.com → New Project
2. Choisir la région la plus proche des utilisateurs
3. SQL Editor → Coller les migrations dans l'ordre
4. Auth → Providers → Configurer (email, Google, GitHub...)
5. Auth → Email Templates → Personnaliser avec Resend
6. Settings → API → Copier :
   - NEXT_PUBLIC_SUPABASE_URL
   - NEXT_PUBLIC_SUPABASE_ANON_KEY
   - SUPABASE_SERVICE_ROLE_KEY (côté serveur uniquement)
7. Ajouter les clés dans Vercel Environment Variables
```

**Points d'attention :**
- Free tier : 500MB DB, 1GB storage, 50K MAU
- **RLS obligatoire** sur toutes les tables avec données utilisateur
- Backups automatiques sur plans payants uniquement (Pro = $25/mois)
- Pause automatique après 1 semaine d'inactivité (free tier)

---

### Railway (Node.js / Python / Go / tout langage)

```
1. railway.app → New Project → Deploy from GitHub Repo
2. Sélectionner le repo et la branche
3. Railway auto-détecte le runtime
4. Variables d'environnement : Variables tab → Add
5. Custom domain : Settings → Networking → Custom Domain
6. Scaling : Settings → Resources (CPU, RAM à la demande)
```

**Points d'attention :**
- Free trial : $5 de crédit
- Pay-as-you-go ensuite (~$5-15/mois pour un petit projet)
- Supporte les WebSockets (Socket.io, etc.)
- Déploiement automatique à chaque push

---

### Fly.io (Containers / global edge)

```bash
curl -L https://fly.io/install.sh | sh
fly auth login
fly launch  # auto-détecte le Dockerfile
fly secrets set KEY=value  # pour chaque variable d'env
fly deploy
fly scale count 2  # haute disponibilité si besoin
```

---

### Cloudflare Pages (statique / JAMstack)

```
1. dash.cloudflare.com → Pages → Create project
2. Connect GitHub → sélectionner le repo
3. Build settings auto-détectés pour les frameworks connus
4. Environment variables → Add
5. Deploy
```

**Points d'attention :**
- Free tier très généreux (500 builds/mois, bandwidth illimité)
- Edge functions via Workers pour la logique serveur
- CDN global automatique

---

### Docker (VPS auto-hébergé)

```dockerfile
# Multi-stage build minimal Next.js
FROM node:22-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build

FROM node:22-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public
EXPOSE 3000
CMD ["node", "server.js"]
```

Adapter le Dockerfile à la stack réelle du projet.

---

## CI/CD — GitHub Actions

### Pipeline basique (Vercel auto-deploy) :

Vercel déploie automatiquement. Ajouter des checks pré-deploy :

```yaml
# .github/workflows/ci.yml
name: CI
on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 22
          cache: 'npm'
      - run: npm ci
      - run: npm run lint
      - run: npx tsc --noEmit
      - run: npm test
      - run: npm run build
```

---

## Rollback d'urgence

| Plateforme | Procédure |
|------------|-----------|
| Vercel | Dashboard → Deployments → Clic sur version précédente → Promote to Production |
| Railway | Dashboard → Deployments → Rollback |
| Fly.io | `fly releases` puis `fly deploy --image [previous-image]` |
| Git (universel) | `git revert HEAD` → push → redeploy automatique |

---

## Intégrations post-déploiement recommandées

| Service | Utilité | Priorité |
|---------|---------|---------|
| **Sentry** | Monitoring erreurs en temps réel | Toujours |
| **Resend** | Emails transactionnels fiables | Si emails |
| **Upstash Redis** | Cache, sessions, rate limiting | Si performance |
| **PostHog** | Analytics produit + feature flags | Recommandé |
| **Cloudflare** | CDN + protection DDoS | Si trafic important |
| **Crisp** | Support client in-app | Si SaaS public |

---

## Format rapport de déploiement

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 WIZARD — Déploiement

Plateforme : [nom]
URL production : [url]
Status : [✅ Succès / ❌ Échec]

✅ Checks passés : [liste]
⚠️ Avertissements : [liste si applicable]
🔴 Bloquants : [si échec — actions à faire]

📋 Post-deploy immédiat :
- [ ] Tester les flows critiques en production
- [ ] Vérifier le monitoring (Sentry)
- [ ] Confirmer que les emails fonctionnent
- [ ] Vérifier les performances (Vercel Analytics / Lighthouse)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

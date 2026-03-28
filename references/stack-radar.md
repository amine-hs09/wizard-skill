# Stack Radar — Découverte dynamique de stack

## Principe fondamental

**Ne jamais recommander une stack hardcodée.** Les frameworks évoluent vite.
Utiliser la web search pour trouver les tendances actuelles AVANT de recommander.

---

## Procédure Stack Discovery

### Étape 1 — Classifier le projet

| Type | Composants à rechercher |
|------|------------------------|
| SaaS Web | frontend, backend/BaaS, auth, payments |
| App Mobile | cross-platform framework, backend, push |
| Landing Page | static site generator, CMS headless |
| API / Backend | runtime, framework, ORM, DB |
| CLI Tool | language, packaging, distribution |
| Data / ML | pipeline, model serving, data storage |
| Automatisation | workflow engine, scheduling, integrations |

### Étape 2 — Web search par catégorie

Remplacer `[YEAR]` par l'année en cours. Exécuter ces queries :

```
# Frontend
"best frontend framework [YEAR] production comparison"
"react next.js remix astro svelte comparison [YEAR]"
"trending frontend GitHub repos [YEAR] stars"

# Backend / BaaS
"best backend framework [YEAR] for [PROJECT_TYPE]"
"supabase firebase appwrite convex comparison [YEAR]"
"best Node.js Python Go Bun Deno framework [YEAR]"

# Base de données
"best database for [USE_CASE] [YEAR]"
"postgresql neon supabase planetscale comparison [YEAR]"

# Auth
"best authentication solution [YEAR] [FRAMEWORK]"
"clerk auth.js lucia better-auth supabase-auth comparison [YEAR]"

# Déploiement
"best hosting platform [YEAR] [PROJECT_TYPE]"
"vercel netlify railway fly.io cloudflare render comparison [YEAR]"

# ORM / Data layer
"best ORM TypeScript [YEAR]"
"drizzle prisma kysely comparison [YEAR]"

# Général
"stackoverflow developer survey [YEAR] most loved"
"state of js [YEAR] results"
"[DOMAIN] best tools [YEAR] developer survey"
```

### Étape 3 — Critères de sélection

| Critère | Solo / Indie | Startup | Enterprise |
|---------|-------------|---------|-----------|
| Vitesse de dev | ★★★ | ★★★ | ★★ |
| Performance | ★ | ★★ | ★★★ |
| Communauté / docs | ★★★ | ★★ | ★★ |
| Scalabilité | ★ | ★★ | ★★★ |
| Coût | ★★★ | ★★ | ★ |
| Maturité / stabilité | ★★ | ★★ | ★★★ |
| DX (developer experience) | ★★★ | ★★★ | ★★ |
| Recrutement (talent pool) | ★ | ★★ | ★★★ |

### Étape 4 — Présenter 2-3 options

```
🔍 STACK DISCOVERY — [Type de projet]

📊 Sources : [surveys/articles consultés — date]

OPTION A — "[Nom descriptif]" ⭐ Recommandée
├── Frontend : [choix] — [pourquoi en 1 ligne]
├── Backend  : [choix] — [pourquoi en 1 ligne]
├── DB       : [choix] — [pourquoi en 1 ligne]
├── Auth     : [choix] — [pourquoi en 1 ligne]
├── Deploy   : [choix] — [pourquoi en 1 ligne]
├── 💰 Coût estimé : [X€/mois pour démarrer]
└── ⚡ Trade-off : [ce qu'on gagne vs ce qu'on sacrifie]

OPTION B — "[Nom descriptif]"
├── ...
└── ⚡ Trade-off : [...]

OPTION C — "[Nom descriptif]" (si pertinent)
└── ...
```

### Étape 5 — Après le choix

1. Persister dans `.wizard/state.json > stack`
2. Vérifier les compatibilités entre les choix retenus
3. Lister les dépendances à installer avec versions exactes
4. Proposer la structure de projet initiale
5. Créer `package.json` / `requirements.txt` adapté (auto en CLI)

---

## Règles anti-biais

- Ne pas toujours recommander Next.js + Supabase par défaut
- Considérer les alternatives non-JS quand pertinent (Python, Go, Rust, Elixir)
- Mentionner quand un outil est en beta vs stable
- Signaler les vendor lock-ins et pricing changes récents
- Citer les sources et dates des informations trouvées

---

## Intégrations optionnelles — Proposer selon le projet

| Intégration | Quand proposer | Coût de départ |
|-------------|---------------|----------------|
| **Stripe** | Si paiements / abonnements | Gratuit + 1.4% par transaction |
| **Resend** | Toujours si emails nécessaires | Gratuit jusqu'à 3000 emails/mois |
| **Upstash Redis** | Si cache, rate limiting, queues | Gratuit tier disponible |
| **Cloudflare** | Si CDN, protection DDoS, workers | Gratuit tier disponible |
| **Sentry** | Toujours en production | Gratuit jusqu'à 5K erreurs/mois |
| **PostHog** | Si analytics produit + feature flags | Gratuit tier généreux |
| **Crisp / Intercom** | Si support client in-app | Crisp gratuit pour petites équipes |
| **Neon DB** | Alternative Supabase avec branching DB | Gratuit tier disponible |
| **Trigger.dev** | Si jobs background, crons | Open source, self-hostable |
| **Inngest** | Si workflows complexes event-driven | Gratuit tier disponible |

---

## Fallback sans web search

Si la web search n'est pas disponible :
- Utiliser la stack recommandée 2025 comme base de référence
- **TOUJOURS préciser** : "Ces recommandations peuvent être légèrement datées. Active la web search avec `wizard update` pour les tendances actuelles."

---

## Commande `wizard update` — Mise à jour des tendances

1. Web search :
   - `"stackoverflow developer survey [YEAR]"`
   - `"state of js [YEAR]"`
   - `"best developer tools [YEAR]"`
   - `"trending GitHub repos [YEAR] most starred"`
2. En mode CLI : vérifier `npm outdated` / `pip list --outdated` dans le projet
3. Scanner `~/.claude/settings.json` → plugins actifs → proposer les manquants
4. Informer l'utilisateur des changements majeurs détectés

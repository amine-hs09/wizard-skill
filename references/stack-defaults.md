# Stack Defaults — Reference par defaut quand web search indisponible

Ce fichier contient la stack recommandee par defaut (Mars 2026).
TOUJOURS preferer le Stack Discovery dynamique (`stack-radar.md`) quand la web search est disponible.
Utiliser ce fichier comme fallback.

---

## Stack SaaS / BaaS recommandee (2026)

| Domaine | Choix | Pourquoi | Alternative |
|---------|-------|----------|-------------|
| Langage | TypeScript | Type-safety, autocompletion, standard enterprise. | JavaScript |
| Framework Front | Next.js 15 | SSR + SSG + API. SEO natif. Ecosystem massif. | Nuxt.js, Remix |
| CSS / UI | Tailwind + shadcn/ui | Rapide, consistant, accessible. Copy-paste. | Chakra UI, Radix |
| State | Zustand + TanStack Query | Leger (2kb), zero boilerplate. Cache serveur auto. | Redux Toolkit, Jotai |
| Database | PostgreSQL | Relationnel, JSONB, full-text search. 100k+ refs. | MySQL, CockroachDB |
| ORM | Prisma | Schema declaratif, migrations auto, type-safe. | Drizzle ORM |
| Auth | NextAuth.js v5 | OAuth, credentials, magic links. RBAC. | Clerk, Supabase Auth |
| API | tRPC | Type-safety end-to-end. Front/back partagent les types. | REST + OpenAPI |
| Validation | Zod | TypeScript-first. Partage client/serveur. | Yup, Valibot |
| Cache | Upstash Redis | Sessions, cache, rate limiting, queues. Serverless. | Redis Cloud |
| Fichiers | Cloudflare R2 | S3-compatible, zero egress fees. | AWS S3, Supabase Storage |
| Hosting | Vercel | Deploy 1-clic, edge, previews. Scale infini. | Railway, Fly.io |
| BaaS | Supabase | PostgreSQL manage + Auth + Storage + Realtime. | Firebase, Neon |
| CI/CD | GitHub Actions | Integration native. Tests, lint, build, deploy auto. | GitLab CI |
| Monitoring | Sentry | Erreurs temps reel + performance. | Datadog |
| Analytics | PostHog | Funnels, feature flags, session replay. Open-source. | Mixpanel, Amplitude |
| Tests | Vitest + Playwright | Unit rapides + E2E navigateur. | Jest + Cypress |
| Paiements | Stripe | Abonnements, factures, portail client. Standard SaaS. | Lemon Squeezy |
| Email | Resend + React Email | Emails en React. Templates maintenables. | SendGrid |
| Recherche | Meilisearch | Recherche instantanee, fuzzy, facettes. | Algolia, Typesense |

---

## Architecture 6 couches

```
COUCHE 1 — FRONTEND (Client)
  Next.js 15 (App Router, SSR, RSC) + TypeScript + Tailwind + shadcn/ui
  State : Zustand + TanStack Query

COUCHE 2 — BACKEND (API)
  Next.js API Routes / tRPC + NextAuth.js v5 (RBAC)
  Validation : Zod end-to-end + Webhooks + Cron

COUCHE 3 — DATA (Storage)
  PostgreSQL (Prisma ORM) + Redis (Upstash) + Cloudflare R2 (fichiers)
  Full-text search + JSONB pour donnees flexibles

COUCHE 4 — INFRA (Hosting)
  Vercel (frontend + API) + Supabase (DB manage) + Docker (services custom)
  CI/CD : GitHub Actions (tests + build + deploy auto)

COUCHE 5 — SECURITE
  RBAC + Row-Level Security + Rate Limiting + WAF Cloudflare
  Chiffrement TLS 1.3 + HttpOnly cookies + Audit Logs

COUCHE 6 — MONITORING
  Sentry (erreurs) + Vercel Analytics (Web Vitals) + PostHog (produit)
  Uptime Robot (monitoring 24/7)
```

---

## Structure dossiers recommandee

```
mon-saas/
│
├── src/
│   ├── app/                          # Next.js App Router
│   │   ├── (auth)/                   # login, register, forgot-pwd, verify
│   │   ├── (dashboard)/              # contenu protege
│   │   │   ├── overview/             # accueil dashboard
│   │   │   ├── products/             # catalogue / entite principale
│   │   │   ├── orders/               # commandes / transactions
│   │   │   ├── team/                 # employes et sous-traitants
│   │   │   ├── tasks/                # gestion des taches
│   │   │   ├── analytics/            # reporting et stats
│   │   │   └── settings/             # parametres compte et org
│   │   ├── (marketing)/              # landing, pricing, about
│   │   ├── api/                      # Route Handlers REST
│   │   └── layout.tsx                # root layout + providers
│   │
│   ├── components/                   # UI reutilisables
│   │   ├── ui/                       # shadcn/ui (button, input, dialog...)
│   │   ├── forms/                    # formulaires metier
│   │   ├── tables/                   # DataTables avec tri, filtre, pagination
│   │   ├── charts/                   # graphiques dashboard
│   │   └── layout/                   # Sidebar, Header, MobileNav
│   │
│   ├── server/                       # code serveur uniquement
│   │   ├── db/                       # Prisma client + queries + seeds
│   │   ├── trpc/                     # routers tRPC par domaine
│   │   ├── auth/                     # NextAuth config + RBAC
│   │   └── services/                 # logique metier
│   │
│   ├── lib/                          # utilitaires partages
│   │   ├── utils.ts                  # cn(), formatDate(), formatCurrency()
│   │   ├── validations.ts            # schemas Zod partages front/back
│   │   └── constants.ts              # enums, config, feature flags
│   │
│   ├── hooks/                        # React hooks custom
│   ├── stores/                       # Zustand (filters, cart, UI state)
│   └── types/                        # TypeScript types globaux
│
├── prisma/                           # schema.prisma + migrations + seed.ts
├── public/                           # logo, favicon, images statiques
├── tests/
│   ├── unit/                         # tests unitaires logique metier
│   └── e2e/                          # tests end-to-end flows critiques
│
├── .env.local                        # JAMAIS COMMIT
├── .env.example                      # template des env vars
├── next.config.ts                    # config Next.js + security headers
├── tailwind.config.ts                # design tokens Tailwind
├── tsconfig.json                     # TypeScript strict mode
├── vitest.config.ts                  # config tests unitaires
├── playwright.config.ts              # config tests E2E
└── .github/workflows/ci.yml          # CI/CD pipeline
```

Adapter selon la stack choisie. Noms de dossiers dans `(dashboard)/` a adapter selon les entites du projet.

---

## Checklist securite SaaS (15 mesures)

### P0 — Bloquant avant production

- [ ] MFA / 2FA : TOTP ou WebAuthn. Obligatoire pour admins.
- [ ] Sessions securisees : JWT court (15min) + refresh (7j). HttpOnly, Secure, SameSite.
- [ ] RBAC + Row-Level Security : chaque query filtree par role ET organisation.
- [ ] Chiffrement : TLS 1.3 partout. Encryption at-rest. Secrets dans env vars.
- [ ] Validation input : Zod sur CHAQUE endpoint. HTML sanitize. Zero SQL dynamique.
- [ ] Sauvegardes auto : daily backup PostgreSQL. Point-in-time recovery. Test restore mensuel.
- [ ] Gestion secrets : jamais dans le code. .env.local en .gitignore. Env vars hosting pour prod.

### P1 — Important

- [ ] Rate Limiting : 100 req/min par user. 10/min sur login.
- [ ] Security Headers : CSP, HSTS, X-Frame-Options, X-Content-Type via next.config.ts.
- [ ] Upload securise : MIME validation, 10MB max, noms UUID.
- [ ] Audit logs : chaque mutation logguee (user, action, timestamp, IP). Retention 90j.
- [ ] GDPR : consentement, droit a l'oubli, export donnees, privacy policy.
- [ ] WAF + DDoS : Cloudflare en front. Rules anti-bot.
- [ ] CORS : origines whitelist explicites. Jamais wildcard en prod.

### P2 — Recommande

- [ ] Audit packages : `npm audit` en CI. Dependabot. Zero vuln critique.

---

## Palette de couleurs par defaut (dark mode SaaS)

| Token | Hex | Usage |
|-------|-----|-------|
| Primary | #5B8AFF | Actions, liens, focus, boutons principaux |
| Accent | #A471FF | Premium, badges, highlights, gradients |
| Success | #00E0B8 | Confirmations, indicateurs positifs |
| Warning | #FF9A5C | Alertes, stock bas, attention |
| Danger | #FF5555 | Erreurs, suppressions, critique |
| Highlight | #FFC845 | Notifications, nouveautes, featured |
| Background | #06060B | Fond principal |
| Card | #111119 | Cards, modals, popovers |
| Border | #1E1E30 | Bordures, dividers |
| Text | #EAEAF2 | Titres, texte principal |
| Secondary | #8888A8 | Descriptions, labels |
| Muted | #52526E | Placeholders, desactive |

### Typographie recommandee

| Usage | Font | Raison |
|-------|------|--------|
| Display / Titres | Playfair Display | Elegant, memorable, premium |
| Body / Interface | Outfit | Moderne, geometrique, lisible |
| Code / Monospace | JetBrains Mono | Refs pieces, donnees techniques, IDs |
| Alternative Body | Inter | Si preference corporate/safe |

Adapter via `/ui-ux-pro-max` ou `/colorize` selon l'industrie et les preferences du discovery.

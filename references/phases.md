# Phases — Discovery, Design, Dev, Polish, QA, Launch

## Phase 0 — Discovery Protocol (25 questions)

Poser ces 25 questions **en une seule fois** regroupees par categorie. Ne commence RIEN avant d'avoir toutes les reponses. C'est la phase la plus importante — 80% des projets echouent parce qu'on l'a sautee.

```
WIZARD — Discovery Protocol

VISION & BUSINESS :
1. Quel probleme ce projet resout ? Pour qui exactement ?
2. Type : SaaS, BaaS, outil interne, marketplace, e-commerce, autre ?
3. Modele de revenus : abonnement, freemium, licence, commission, gratuit ?
4. Concurrents principaux ? Ce qui nous differencie ?
5. Pitch en 1 phrase : "C'est [quoi] pour [qui] qui permet de [action]"

UTILISATEURS & ROLES :
6. Types d'utilisateurs ? (admin, manager, employe, sous-traitant, client)
7. Workflow quotidien de chaque persona ?
8. Devices principaux : desktop, mobile, tablette ?
9. Niveau technique des utilisateurs ?
10. Combien d'utilisateurs simultanes prevu ? Au lancement ? A 1 an ?

FEATURES & SCOPE :
11. 3-5 features CORE du MVP ? (minimum vital pour lancer)
12. Features V2 / V3 ? (pas maintenant)
13. Integrations externes : paiement, email, SMS, API tierces, import/export ?
14. Temps reel necessaire ? (chat, notifications live, updates auto)
15. Multi-langue ?

DONNEES & BASE :
16. Entites principales ? (Produit, Commande, User, Facture...)
17. Volume : 100 lignes ? 10k ? 100k+ ? 1M+ ?
18. Relations complexes ? (many-to-many, hierarchies, historique)
19. Recherche avancee ? (full-text, filtres multiples, facettes)
20. Import de donnees existantes ? (Excel, CSV, autre systeme)

DESIGN & IDENTITE :
21. Ton : corporate, moderne, fun, luxe, minimaliste, tech ?
22. Charte existante ? Logo, couleurs, fonts ?
23. Dark mode, light mode, ou les deux ?
24. Style : glassmorphism, bento grid, clean, brutalist, neumorphism ?
25. 3 sites/apps de reference qui te plaisent visuellement
```

### Apres les reponses :
1. Resumer les choix en 5-8 lignes
2. Determiner le niveau securite : standard / renforce / strict
3. Si stack = "Wizard choisit" → lancer Stack Discovery (`stack-radar.md`)
4. Persister dans `.wizard/state.json`
5. Proposer le plan de phases avec estimation

---

## Phase 1 — Fondations & Design System

**Objectif :** Poser les bases techniques et visuelles. Tout ce qui est decide ici impacte le reste.

### Actions :
1. Init projet (Next.js + TypeScript + Tailwind + shadcn/ui ou stack choisie)
2. Setup Prisma/ORM + base de donnees + schema initial
3. Setup Git, ESLint, Prettier, Husky pre-commit hooks
4. Configurer la structure des dossiers
5. Setup CI/CD (GitHub Actions)
6. Creer `.env.example` + `.gitignore` complet

### Skills a utiliser :
- `/teach-impeccable` — Config contexte design du projet (une seule fois)
- `/ui-ux-pro-max` — Generer le design system complet (couleurs, typo, composants)
- `/brainstorming` — Explorer les approches d'implementation
- `/writing-plans` — Ecrire le plan d'implementation detaille
- `/colorize` — Definir la palette de couleurs
- `/typeset` — Choix typographiques

### Livrables :
- Repo Git configure
- Design system (couleurs, typo, composants de base)
- Schema DB initial
- CI/CD fonctionnel
- Plan d'implementation complet

---

## Phase 2 — Auth & Securite

**Objectif :** Le mur porteur de l'app. Authentification et autorisation AVANT tout le reste.

### Actions :
1. Auth complete : login, register, forgot password, magic links
2. RBAC : definir les roles selon le discovery (ex: Admin, Manager, Worker, Subcontractor)
3. Row-Level Security si PostgreSQL/Supabase
4. Middleware protection de routes par role
5. Rate limiting sur endpoints sensibles
6. Security headers (CSP, HSTS, X-Frame-Options)

### Skills a utiliser :
- `/frontend-design` — Pages d'auth
- `/harden` — Tester les edge cases auth
- `/audit` — Check accessibilite des formulaires
- `/test-driven-development` — Tests auth critiques
- `/clarify` — Messages d'erreur clairs et utiles

### Livrables :
- Systeme auth complet fonctionnel
- RBAC avec tous les roles
- RLS configure
- Tests de securite passes

---

## Phase 3 — Core Features (MVP)

**Objectif :** Les 3-5 features qui font que le produit existe. Pas plus. Focus absolu.

### Actions :
1. Schema DB complet (toutes entites, relations, indexes)
2. CRUD pour chaque entite principale
3. Recherche + filtres + pagination
4. Upload fichiers si necessaire
5. Dashboard avec metriques cles
6. Validation end-to-end (Zod ou equivalent)

### Skills a utiliser :
- `/frontend-design` — Chaque page
- `/ui-ux-pro-max` — Charts et dashboard
- `/arrange` — Layout des data tables
- `/typeset` + `/colorize` — Raffiner le visuel
- `/executing-plans` — Suivre le plan etape par etape

### Livrables :
- Features MVP 100% fonctionnelles
- Dashboard avec donnees
- CRUD + recherche + uploads

---

## Phase 4 — Collaboration & Multi-Users

**Objectif :** Permettre a tous les utilisateurs de travailler ensemble dans leur perimetre.

### Actions :
1. Espaces par role (admin voit tout, sous-traitant voit le sien)
2. Notifications in-app + email
3. Gestion taches et assignation
4. Historique et audit logs
5. Export PDF / Excel
6. Invitations par email avec roles

### Skills a utiliser :
- `/onboard` — Flow d'onboarding pour nouveaux utilisateurs
- `/pdf` — Exports PDF (factures, bons de commande)
- `/xlsx` — Exports Excel (inventaires, rapports)
- `/clarify` — UX copy des notifications
- `/harden` — Permissions edge cases

### Livrables :
- Multi-tenant fonctionnel
- Notifications temps reel
- Exports PDF/Excel
- Audit logs
- Systeme d'invitations

---

## Phase 5 — Polish Enterprise

**Objectif :** Passer de "ca marche" a "c'est premium". Le niveau de finition qui fait la difference.

### Actions :
1. Passe finale sur chaque page et composant
2. Animations et micro-interactions sur les actions cles
3. Loading states, error states, empty states partout
4. Dark mode / light mode si demande
5. Responsive test sur tous les devices
6. Accessibilite WCAG AA minimum

### Skills a utiliser :
- `/polish` — Passe finale pixel-perfect
- `/animate` — Micro-interactions
- `/delight` — Moments de joie
- `/adapt` — Responsive complet
- `/bolder` ou `/quieter` — Ajuster l'intensite visuelle
- `/normalize` — Consistance entre toutes les pages

### Livrables :
- UI pixel-perfect et coherente
- Animations fluides
- Responsive tous devices
- Accessibilite validee
- Dark mode si demande

---

## Phase 6 — Testing & QA

**Objectif :** Zero bug en production. Rien ne passe sans validation.

### Actions :
1. Tests unitaires sur la logique metier
2. Tests E2E sur les flows critiques (login, CRUD, paiement)
3. Audit accessibilite automatise
4. Audit performance (Lighthouse 90+)
5. Audit securite (OWASP top 10)
6. Review de code complete

### Skills a utiliser :
- `/test-driven-development` — Tests complets
- `/webapp-testing` — Tests navigateur Playwright
- `/audit` — Audit technique
- `/critique` — Audit UX avec scoring
- `/code-review` — Review code finale
- `/optimize` — Performance
- `/systematic-debugging` — Si bugs detectes

### Livrables :
- Suite de tests verts
- Rapport d'audit (accessibilite, performance, securite)
- Code review passee
- Lighthouse 90+

---

## Phase 7 — Launch & Monitor

**Objectif :** Deployer, monitorer, iterer. Le produit est vivant.

### Actions :
1. Deploy sur l'hosting choisi (Vercel, Railway, etc.)
2. Domaine custom + SSL + CDN
3. Monitoring erreurs (Sentry)
4. Analytics produit (PostHog ou equivalent)
5. Uptime monitoring 24/7
6. Paiements si SaaS payant (Stripe)
7. Documentation utilisateur

### Skills a utiliser :
- `/verification-before-completion` — Check final avant launch
- `/systematic-debugging` — Bugs post-launch
- `/docx` ou `/pdf` — Documentation utilisateur
- `/pptx` — Presentation de lancement si besoin
- `/mcp-builder` — Integrations custom

### Livrables :
- App en production avec domaine custom
- Monitoring actif (erreurs + uptime)
- Analytics en place
- Documentation utilisateur
- Paiement en place si applicable

---

## Post-lancement

### Semaine 1 — Monitoring actif
- Erreurs dans Sentry
- Performance (Core Web Vitals)
- Couts reels vs estimation
- Feedback utilisateurs

### Semaine 2-4 — Stabilisation
- Corriger les bugs critiques
- Optimiser les queries lentes
- Ajuster rate limiting / quotas

### Mois 2+ — Roadmap V2
- Analyser les patterns d'usage (PostHog)
- Prioriser les features demandees
- Proposer la roadmap V2

### Format review post-lancement :
```
WIZARD — Review post-lancement

OK : [ce qui fonctionne bien]
A ameliorer : [optimisations possibles]
Urgent : [bugs/issues critiques]
Couts : [estimation mensuelle reelle]
Roadmap V2 : [top 3 features suggerees]
```

---

## Guide UX — Quel skill selon le probleme detecte

| Probleme | Skill |
|----------|-------|
| Interface terne / generique | `/bolder` ou `/colorize` |
| Interface surchargee | `/distill` |
| Interface trop agressive | `/quieter` |
| Labels / textes pas clairs | `/clarify` |
| Pas responsive | `/adapt` |
| Manque d'animations | `/animate` |
| Performance lente | `/optimize` |
| Design incoherent entre pages | `/normalize` ou `/extract` |
| Pas d'onboarding | `/onboard` |
| Typographie faible | `/typeset` |
| Spacing / layout bancal | `/arrange` |
| Manque de personnalite | `/delight` |
| Evaluation UX globale | `/critique` |
| Passe finale avant livraison | `/polish` |
| Check technique complet | `/audit` |
| Cas limites / erreurs | `/harden` |
| Bug ou comportement inattendu | `/systematic-debugging` |
| Code trop complexe | `/simplify` |
| Avant de dire "c'est fini" | `/verification-before-completion` |

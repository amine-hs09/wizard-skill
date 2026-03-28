# Skills Catalog — 50+ skills organises par categorie

## Comment utiliser ce catalogue

Wizard consulte ce fichier pour savoir quel skill invoquer selon la situation.
Toujours utiliser la commande `/nom-du-skill` pour lancer un skill.

---

## Skills UI / Design (22 skills locaux installes)

### Creation — Construire de zero

| Situation | Skill | Description |
|-----------|-------|-------------|
| Creer une page / composant | `/frontend-design` | UI production-grade, evite le generique AI-slop. Skill maitre. |
| Setup design une fois pour toutes | `/teach-impeccable` | Configure contexte design persistant pour le projet. |
| Design complet (palettes, charts, typo) | `/ui-ux-pro-max` | 67 styles, 161 palettes, 57 font pairings, 25 charts, 13 stacks. |
| Extraire composants reutilisables | `/extract` | Design tokens, composants partages, consolidation. |
| Onboarding / premier lancement | `/onboard` | Parcours utilisateur, empty states, activation. |

### Raffinement — Ameliorer l'existant

| Situation | Skill | Description |
|-----------|-------|-------------|
| Passe finale avant livraison | `/polish` | Alignement, coherence, micro-details. De "bon" a "premium". |
| Interface trop terne / generique | `/bolder` | Amplifie l'impact visuel et la personnalite. |
| Interface trop agressive | `/quieter` | Adoucit pour un rendu plus elegant et pro. |
| Interface trop complexe | `/distill` | Simplifie radicalement, enleve l'inutile. |
| Design incoherent entre pages | `/normalize` | Realigne sur le design system. |
| Ajouter moments de plaisir | `/delight` | Micro-interactions, easter eggs, surprise. |
| Mode "wow factor" maximum | `/overdrive` | Shaders, spring physics, animations 60fps. |

### Typographie, Couleur & Layout

| Situation | Skill | Description |
|-----------|-------|-------------|
| Probleme typographie | `/typeset` | Fonts, hierarchie, tailles, graisses, lisibilite. |
| Ajouter de la couleur | `/colorize` | Strategie couleur pour apps monochromes. |
| Problemes layout / spacing | `/arrange` | Rythme visuel, grilles, espacement. |
| App pas responsive | `/adapt` | Mobile-first, breakpoints, touch targets, container queries. |

### Motion & Animation

| Situation | Skill | Description |
|-----------|-------|-------------|
| Manque d'animations | `/animate` | Hover states, transitions, reveals au scroll. |

### Qualite & Audit

| Situation | Skill | Description |
|-----------|-------|-------------|
| Check technique complet | `/audit` | Accessibilite, performance, theming, responsive. Rapport P0-P3. |
| Evaluation UX globale | `/critique` | Hierarchie visuelle, charge cognitive, scoring. |
| Cas limites / erreurs / i18n | `/harden` | Overflow, erreurs, permissions, etats vides. Production-ready. |
| Performance lente | `/optimize` | LCP, CLS, bundle size, images, lazy loading. |
| Textes / labels peu clairs | `/clarify` | UX copy, messages d'erreur, labels. |

---

## Skills Developpement (Superpowers)

| Situation | Skill | Quand l'utiliser |
|-----------|-------|-----------------|
| Avant toute tache multi-etapes | `/writing-plans` | Ecrire le plan AVANT de coder |
| Executer un plan existant | `/executing-plans` | Session d'execution avec checkpoints |
| Avant de creer une feature | `/brainstorming` | Explorer les options d'abord |
| Taches paralleles independantes | `/dispatching-parallel-agents` | 2+ taches sans dependance |
| Feature isolee | `/using-git-worktrees` | Isolation dans un worktree |
| Avant d'ecrire une fonction | `/test-driven-development` | Tests d'abord |
| Bug ou erreur detectee | `/systematic-debugging` | Avant de proposer un fix |
| Avant de dire "c'est termine" | `/verification-before-completion` | Toujours avant de valider |
| Avant de merger / creer PR | `/requesting-code-review` | Verification pre-merge |
| Feedback de review recu | `/receiving-code-review` | Avant d'implementer les suggestions |
| Code trop complexe | `/simplify` | Simplifier, dedupliquer |
| Taches paralleles dans la session | `/subagent-driven-development` | Agents paralleles |
| Finaliser une branche | `/finishing-a-development-branch` | Cloturer proprement |
| Creer un skill custom | `/writing-skills` | Creer / modifier des skills |

---

## Skills Integres (actifs automatiquement)

| Situation | Skill | Description |
|-----------|-------|-------------|
| Charte graphique / brand | `/brand-guidelines` | Couleurs et typo officielles sur tous les documents. |
| Creer un serveur MCP | `/mcp-builder` | Connecteurs API externes (Stripe, Supabase, custom). |
| Tester une app web locale | `/webapp-testing` | Playwright : screenshots, UI, logs navigateur. |
| Co-rediger documentation | `/doc-coauthoring` | Workflow structure pour specs, proposals, docs. |
| Creer un skill custom | `/skill-creator` | Creer, modifier, tester des skills. |
| Construire avec l'API Claude | `/claude-api` | Integration SDK Anthropic dans un SaaS. |

---

## Skills Securite

| Situation | Skill | Quand l'utiliser |
|-----------|-------|-----------------|
| Audit securite global | `security-guidance` | Avant la mise en prod |
| Apres avoir code l'auth | `/harden` | Validation, CSRF, rate limiting |
| Code sensible (paiements, donnees perso) | `security-guidance` | Obligatoire |
| Verification avant mise en prod | `security-guidance` + `/audit` | Toujours |

---

## Skills Documents & Communication

| Situation | Skill | Quand l'utiliser |
|-----------|-------|-----------------|
| Creer un Word | `/docx` | Documents .docx |
| Creer un PDF | `/pdf` | Documents PDF |
| Creer un Excel | `/xlsx` | Tableurs |
| Creer une presentation | `/pptx` | PowerPoint |
| Co-rediger documentation | `/doc-coauthoring` | Docs structurees |

---

## Skills deprecies — NE JAMAIS utiliser :

| Deprecie | Remplacant |
|----------|-----------|
| `superpowers:brainstorm` | `superpowers:brainstorming` |
| `superpowers:execute-plan` | `superpowers:executing-plans` |
| `superpowers:write-plan` | `superpowers:writing-plans` |

---

## Plugins MCP recommandes par type de projet

### Plugins actuellement actifs

| Plugin | Usage |
|--------|-------|
| `context7` | Docs a jour de n'importe quelle librairie — utiliser systematiquement |
| `superpowers` | Plans, debugging, review, parallel agents |
| `frontend-design` | UI production-grade |
| `code-review` | Review PR GitHub |
| `code-simplifier` | Nettoyer le code apres chaque module |
| `security-guidance` | Audit securite |
| `document-skills` | PDF, DOCX, XLSX, PPTX |

### Plugins a installer selon le projet

| Projet necessite | Plugin | Comment installer |
|-----------------|--------|------------------|
| Gestion GitHub avancee | GitHub MCP | Settings > Extensions > GitHub |
| Base de donnees Supabase | Supabase MCP | Settings > Extensions > Supabase |
| Paiements Stripe | Stripe MCP | Settings > Extensions > Stripe |
| Deploiements Vercel | Vercel MCP | Settings > Extensions > Vercel |
| Emails Resend | Resend MCP | Settings > Extensions > Resend |
| Monitoring erreurs | Sentry MCP | Settings > Extensions > Sentry |

---

## Commande `wizard skills`

Quand l'utilisateur tape "wizard skills", afficher les skills pertinents pour la phase actuelle :

```
WIZARD — Skills recommandes

Phase : [phase actuelle]

MAINTENANT :
> /[skill1] — [raison]
> /[skill2] — [raison]

PROCHAINEMENT :
> /[skill3] — [quand]

MANQUANTS :
> [plugin X] — a installer pour [raison]
```

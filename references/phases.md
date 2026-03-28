# Phases — Cadrage, Design, Développement, Post-lancement

## Phase Cadrage — 9 questions

Poser ces 9 questions **en une seule fois**. Réponses courtes acceptées.

```
🧙 WIZARD — Cadrage projet

1. TYPE : SaaS web / App mobile / Landing / API-Backend / CLI / Autre ?
2. EN 1 PHRASE : Qu'est-ce que ça fait ?
3. UTILISATEURS : Qui utilise ça ? (devs, clients, interne, public)
4. V1 — TOP 3 : Les 3 features indispensables au lancement ?
5. DÉLAI : Quand ça doit être en ligne ?
6. BUDGET : 0€ / ~10-20€/mois / Plus ?
7. SÉCURITÉ : Publique / Interne / Données sensibles (RGPD) ?
8. STACK : Wizard choisit (recommandé) / J'ai déjà une stack ?
9. GITHUB : Wizard gère automatiquement / Je gère moi-même ?
```

### Après les réponses :
1. Résumer les choix en 5 lignes max
2. Si stack = "Wizard choisit" → lancer Stack Discovery (`stack-radar.md`)
3. Persister dans `.wizard/state.json`
4. Proposer le plan de phases avec estimation de durée

---

## Phase Design (si projet avec UI)

Poser ces 5 questions **avant de créer le moindre composant** :

1. **Style** : minimal, bold, corporate, playful, brutalist, élégant ?
2. **Mode** : clair, sombre, les deux ?
3. **Couleurs** : logo/charte existante ou libres ?
4. **Références** : sites ou apps qui plaisent (et pourquoi) ?
5. **Anti-patterns** : ce que l'utilisateur ne veut SURTOUT PAS ?

### Actions :
- En **mode CLI** : créer `.impeccable.md` à la racine avec le contexte design
- En **mode Chat** : stocker mentalement pour cohérence sur tous les composants
- Persister dans `state.json > design`

### Règle absolue :
Ne jamais créer d'UI sans avoir ce contexte. Si `.impeccable.md` manque → lancer `/teach-impeccable`.

---

## Phase Développement — Flow par feature

Pour chaque feature, suivre cette séquence stricte :

### 1. Explorer (avant de coder)
- Quelles approches possibles ?
- Compromis : complexité vs rapidité vs maintenabilité
- Librairie existante vs code custom ?
- → Utiliser `superpowers:brainstorming`

### 2. Planifier
- Fichiers à créer/modifier
- Dépendances à installer
- Impact sur les features existantes
- → Utiliser `superpowers:writing-plans`

### 3. Coder
- Code complet, production-ready
- Typage strict (TypeScript si applicable)
- Gestion d'erreurs intégrée
- Mode CLI : créer les fichiers directement
- Mode Chat : code + instructions claires

### 4. Sécuriser
- Validation des inputs (Zod, class-validator, Pydantic...)
- Sanitization des outputs
- Permissions vérifiées
- → Utiliser `/harden` après chaque module

### 5. Tester
- Tests critiques (pas exhaustifs)
- Mode CLI : créer les fichiers de test et les exécuter
- Mode Chat : fournir les tests à copier
- → Utiliser `superpowers:test-driven-development`

### 6. Simplifier & Valider
- Vérifier duplications → `/simplify`
- Valider que tout fonctionne → `superpowers:verification-before-completion`
- Mettre à jour `state.json > features_done`

### Guide UX selon situation détectée

| Problème | Skill à utiliser |
|----------|-----------------|
| Interface trop terne | `/bolder` ou `/colorize` |
| Interface surchargée | `/distill` |
| Labels pas clairs | `/clarify` |
| Pas responsive | `/adapt` |
| Manque d'animations | `/animate` |
| Performances lentes | `/optimize` |
| Design incohérent | `/normalize` ou `/extract` |
| Pas d'onboarding | `/onboard` |
| Typographie faible | `/typeset` |
| Problèmes spacing/layout | `/arrange` |
| Trop agressif visuellement | `/quieter` |
| Moments de plaisir manquants | `/delight` |
| Évaluation UX globale | `/critique` |
| Passe finale avant livraison | `/polish` |
| Accessibilité + performance | `/audit` |

---

## Phase Post-lancement

### Semaine 1 — Monitoring actif

Vérifier :
- Erreurs dans les logs (plateforme hosting + DB)
- Métriques de performance (temps de réponse, Core Web Vitals)
- Coûts réels vs estimation
- Feedback utilisateurs

### Semaine 2-4 — Stabilisation

- Corriger les bugs critiques remontés
- Optimiser les queries lentes identifiées
- Ajuster les limites (rate limiting, quotas)

### Mois 2+ — Roadmap v2

- Analyser les patterns d'usage
- Prioriser les features demandées
- Proposer la roadmap v2 avec estimation

### Format review post-lancement

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 WIZARD — Review post-lancement

🟢 OK : [ce qui fonctionne bien]
🟡 À améliorer : [optimisations possibles]
🔴 Urgent : [bugs/issues critiques]
💰 Coûts : [estimation mensuelle réelle]
🗺️ Roadmap v2 : [top 3 features suggérées]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

# GitHub Flow — Workflow & MCP Integration

## Détection du mode GitHub

Au début d'un projet, détecter :
1. **GitHub MCP disponible** → actions directes (créer repo, issues, PRs)
2. **CLI avec git** → commandes git directes
3. **Chat sans MCP** → instructions à copier-coller

---

## Structure de branches

```
main            ← production (protégée, deploy auto)
├── develop     ← intégration (optionnel si projet solo)
├── feature/xxx ← nouvelles features
├── fix/xxx     ← corrections de bugs
└── hotfix/xxx  ← urgences production
```

**Projet solo** : main + feature branches suffit. Pas besoin de develop.
**Équipe** : main + develop + feature branches. PRs obligatoires.

---

## Conventions de commits (Conventional Commits)

```
type(scope): description courte

Types :
feat:     nouvelle fonctionnalité
fix:      correction de bug
chore:    maintenance, dépendances, config
docs:     documentation
refactor: restructuration sans changement fonctionnel
test:     ajout/modification de tests
style:    formatage, CSS, UI sans changement logique
perf:     optimisation de performance
ci:       configuration CI/CD

Exemples :
feat(auth): add Google OAuth login
fix(api): handle null response from payment gateway
chore: upgrade dependencies to latest stable
docs(readme): add deployment instructions
refactor(db): extract query builder into separate module
```

---

## Setup initial du repo

### Fichiers à créer automatiquement (mode auto) :

**.gitignore** — adapté à la stack choisie :
- Node.js : `node_modules/`, `.next/`, `.env*.local`
- Python : `__pycache__/`, `.venv/`, `.env`
- Général : `.env`, `.DS_Store`, `*.log`, `.wizard/state.json` (optionnel)

**.editorconfig** :
```ini
root = true

[*]
indent_style = space
indent_size = 2
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true

[*.md]
trim_trailing_whitespace = false

[*.py]
indent_size = 4
```

**README.md** — généré selon le projet (voir project-advisor skill pour le template).

---

## Workflow par feature

### 1. Créer la branche

```bash
git checkout -b feature/nom-descriptif
```

Avec GitHub MCP : créer aussi une issue liée si pertinent.

### 2. Développer avec commits atomiques

Chaque commit = un changement logique. Pas de commits "WIP" ou "fix stuff".

```bash
# Ajouter sélectivement
git add -p

# Commit avec message conventionnel
git commit -m "feat(module): description claire"
```

### 3. Vérification pré-merge (WIZARD check)

Avant de merger, WIZARD vérifie :

| Check | Mode CLI | Mode Chat |
|-------|----------|-----------|
| Lint passes | `npx eslint .` / `ruff check .` | "Lance ton linter" |
| Tests passent | `npm test` / `pytest` | "Lance tes tests" |
| Pas de .env | `git diff --cached --name-only \| grep -i env` | "Vérifie tes fichiers staged" |
| Types OK | `npx tsc --noEmit` | "Lance le type check" |
| Build OK | `npm run build` | "Teste le build" |

### 4. Pull Request

**Template PR (à créer dans `.github/pull_request_template.md`)** :

```markdown
## Description
[Ce que fait cette PR en 2-3 phrases]

## Type de changement
- [ ] Feature
- [ ] Fix
- [ ] Refactoring
- [ ] Documentation

## Checklist
- [ ] Tests ajoutés/mis à jour
- [ ] Documentation mise à jour
- [ ] Pas de console.log / print de debug
- [ ] Pas de secrets exposés
- [ ] Testé localement

## Screenshots (si UI)
[Avant / Après]
```

Avec GitHub MCP : créer la PR automatiquement avec ce template.

### 5. Merge et nettoyage

```bash
# Merger (squash si beaucoup de petits commits)
git checkout main  # ou develop
git merge feature/nom-descriptif  # ou squash merge via PR

# Nettoyer
git branch -d feature/nom-descriptif
git push origin --delete feature/nom-descriptif
```

---

## GitHub Actions — CI/CD basique

Créer `.github/workflows/ci.yml` adapté à la stack :

**Template Node.js/TypeScript** :
```yaml
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
      - run: npm run type-check
      - run: npm test
      - run: npm run build
```

**Template Python** :
```yaml
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
      - uses: actions/setup-python@v5
        with:
          python-version: '3.12'
      - run: pip install -r requirements.txt
      - run: ruff check .
      - run: pytest
```

Adapter selon la stack réelle du projet. Ne pas copier-coller aveuglément.

---

## Labels GitHub recommandés

Avec GitHub MCP, créer ces labels au setup :

| Label | Couleur | Usage |
|-------|---------|-------|
| `bug` | #d73a4a | Bug confirmé |
| `feature` | #0075ca | Nouvelle feature |
| `enhancement` | #a2eeef | Amélioration existante |
| `documentation` | #0075ca | Documentation |
| `good first issue` | #7057ff | Pour les contributeurs (si open source) |
| `priority: high` | #b60205 | Urgent |
| `priority: low` | #c5def5 | Peut attendre |
| `wontfix` | #ffffff | Ne sera pas traité |

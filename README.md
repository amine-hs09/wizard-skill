# 🧙 WIZARD — Chef de Projet IA pour Claude

**Wizard est un skill Claude Code qui te guide de A à Z dans le développement de n'importe quel projet.** Stack discovery dynamique, 90+ skills orchestrés, GitHub intégré, sécurité active, mode enterprise.

---

## Installation en 1 ligne

```bash
curl -fsSL https://raw.githubusercontent.com/OtmanHSSINOUI/wizard-skill/main/install.sh | bash
```

Ou manuellement :

```bash
git clone https://github.com/OtmanHSSINOUI/wizard-skill.git
cd wizard-skill
bash install.sh
```

---

## Démarrage

**Dans Claude Code CLI :**
```
/wizard
```
ou tape : `active le wizard`, `nouveau projet`, `je veux créer...`

**Dans Claude.ai Chat / Cowork :**
1. Glisse le fichier `desktop/WIZARD-pour-Claude-Chat.md` dans la conversation
2. Dis : **"Active le Wizard"**

---

## Ce que Wizard fait

| Capacité | Détail |
|----------|--------|
| 🔍 **Stack Discovery** | Web search avant toute recommandation — jamais hardcodé |
| 📋 **Cadrage** | 9 questions, plan complet, estimation de durée |
| 🎨 **Design** | Contexte UI avant chaque composant |
| 🗄️ **Architecture DB** | Schémas SQL, RLS Supabase, migrations, multi-tenant |
| 🔒 **Sécurité** | 3 niveaux (standard / renforcé / strict RGPD) |
| 🐙 **GitHub Flow** | Branches, commits conventionnels, PR templates, CI/CD |
| 🚀 **Déploiement** | Vercel, Supabase, Railway, Fly.io, Docker, rollback |
| 🏢 **Enterprise** | SSO/SAML, Vault, RBAC, SOC2, RGPD, audit trail |
| 🤖 **90+ Skills** | Orchestre les skills Claude Code au bon moment |
| 💾 **Persistance** | `.wizard/state.json` — reprend le contexte entre sessions |

---

## Commandes disponibles

```
wizard              → Démarre le flow complet
wizard status       → État actuel, phase, stack, features
wizard plan         → Plan complet restant
wizard next         → Prochaine étape prioritaire
wizard stack        → Lance Stack Discovery dynamique
wizard github       → Setup ou status GitHub
wizard deploy       → Guide déploiement
wizard security     → Audit sécurité actif
wizard skills       → Skills recommandés pour la phase actuelle
wizard update       → Scan des nouveaux plugins et tendances
wizard enterprise   → Mode grande organisation (SSO, RBAC, compliance)
```

---

## Structure du skill

```
wizard-skill/
├── SKILL.md                    # Core du skill (chargé par Claude Code)
├── install.sh                  # Installateur automatique
├── scripts/
│   └── wizard-startup.sh       # Hook SessionStart (alerte au lancement)
├── desktop/
│   └── WIZARD-pour-Claude-Chat.md  # Version standalone pour Claude Chat
└── references/
    ├── phases.md               # Cadrage, design, dev, post-lancement
    ├── stack-radar.md          # Stack discovery dynamique
    ├── db-architect.md         # Architecture DB, RLS, migrations
    ├── security-audit.md       # Audit sécurité 3 niveaux
    ├── github-flow.md          # GitHub MCP, branches, CI/CD
    ├── deploy-guide.md         # Déploiement multi-plateformes
    ├── skills-catalog.md       # Catalogue 90+ skills
    └── enterprise.md           # Mode grande organisation
```

---

## Compatibilité

| Environnement | Statut | Instructions |
|---------------|--------|-------------|
| Claude Code CLI | ✅ Natif | `/wizard` après installation |
| Claude.ai Chat | ✅ Standalone | Glisser `WIZARD-pour-Claude-Chat.md` |
| Claude Cowork | ✅ Standalone | Glisser `WIZARD-pour-Claude-Chat.md` |
| Claude Mobile | ✅ Standalone | Coller le contenu du fichier Chat |

---

## Ce que Wizard orchestre

Wizard sait exactement **quand utiliser quel skill** :

- **Avant de coder** → `superpowers:writing-plans` + `superpowers:brainstorming`
- **Sur un bug** → `superpowers:systematic-debugging`
- **UI à créer** → `/frontend-design` avec contexte design
- **Avant de merger** → `superpowers:requesting-code-review`
- **Après un module** → `/simplify` + `superpowers:verification-before-completion`
- **Sécurité** → `security-guidance` + `/harden`
- **Tâches parallèles** → `superpowers:dispatching-parallel-agents`

---

## Hook SessionStart (alerte automatique)

Une fois installé, à chaque lancement de Claude Code CLI :

```
🧙 WIZARD — Projet en cours : MonProjet | Phase : développement
   → Tape `wizard next` pour continuer
```

Et tous les 7 jours :
```
🧙 WIZARD — Mise à jour disponible
   → Tape `wizard update` pour scanner les nouveaux skills
```

---

## Auteur

Créé par **Otman Hssinoui** — GM d'Unico Consult
Version : **3.0** — Mars 2026

---

## Licence

MIT — Libre d'utilisation, modification et distribution.

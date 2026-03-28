#!/bin/bash
# ============================================================
# WIZARD — Installateur automatique pour Claude Code CLI
# Usage : curl -fsSL https://raw.githubusercontent.com/OtmanHSSINOUI/wizard-skill/main/install.sh | bash
# ============================================================

set -e

WIZARD_DIR="$HOME/.claude/skills/wizard"
REPO_URL="https://raw.githubusercontent.com/OtmanHSSINOUI/wizard-skill/main"
SCRIPTS_DIR="$HOME/.claude/scripts"

echo ""
echo "🧙 WIZARD — Installation..."
echo ""

# 1. Créer les dossiers
mkdir -p "$WIZARD_DIR/references"
mkdir -p "$WIZARD_DIR/desktop"
mkdir -p "$SCRIPTS_DIR"

# 2. Télécharger les fichiers Wizard
echo "📦 Téléchargement des fichiers..."

curl -fsSL "$REPO_URL/SKILL.md" -o "$WIZARD_DIR/SKILL.md"
curl -fsSL "$REPO_URL/references/phases.md" -o "$WIZARD_DIR/references/phases.md"
curl -fsSL "$REPO_URL/references/stack-radar.md" -o "$WIZARD_DIR/references/stack-radar.md"
curl -fsSL "$REPO_URL/references/db-architect.md" -o "$WIZARD_DIR/references/db-architect.md"
curl -fsSL "$REPO_URL/references/security-audit.md" -o "$WIZARD_DIR/references/security-audit.md"
curl -fsSL "$REPO_URL/references/github-flow.md" -o "$WIZARD_DIR/references/github-flow.md"
curl -fsSL "$REPO_URL/references/deploy-guide.md" -o "$WIZARD_DIR/references/deploy-guide.md"
curl -fsSL "$REPO_URL/references/skills-catalog.md" -o "$WIZARD_DIR/references/skills-catalog.md"
curl -fsSL "$REPO_URL/references/enterprise.md" -o "$WIZARD_DIR/references/enterprise.md"
curl -fsSL "$REPO_URL/desktop/WIZARD-pour-Claude-Chat.md" -o "$WIZARD_DIR/desktop/WIZARD-pour-Claude-Chat.md"
curl -fsSL "$REPO_URL/scripts/wizard-startup.sh" -o "$SCRIPTS_DIR/wizard-startup.sh"

chmod +x "$SCRIPTS_DIR/wizard-startup.sh"

echo "✅ Fichiers installés"

# 3. Configurer le SessionStart hook dans settings.json
SETTINGS_FILE="$HOME/.claude/settings.json"

if [ ! -f "$SETTINGS_FILE" ]; then
  echo '{"hooks":{"SessionStart":[{"hooks":[{"type":"command","command":"bash ~/.claude/scripts/wizard-startup.sh 2>/dev/null || true"}]}]}}' > "$SETTINGS_FILE"
  echo "✅ settings.json créé avec hook SessionStart"
else
  # Vérifier si le hook existe déjà
  if grep -q "wizard-startup" "$SETTINGS_FILE" 2>/dev/null; then
    echo "ℹ️  Hook SessionStart déjà configuré"
  else
    echo ""
    echo "⚠️  Pour activer le hook de démarrage automatique, ajoute ceci dans ~/.claude/settings.json :"
    echo ""
    echo '  "hooks": {'
    echo '    "SessionStart": [{'
    echo '      "hooks": [{'
    echo '        "type": "command",'
    echo '        "command": "bash ~/.claude/scripts/wizard-startup.sh 2>/dev/null || true"'
    echo '      }]'
    echo '    }]'
    echo '  },'
    echo ""
  fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🧙 WIZARD installé avec succès !"
echo ""
echo "📁 Emplacement : $WIZARD_DIR"
echo "📋 9 modules de référence installés"
echo "🖥️  Version Claude Chat : $WIZARD_DIR/desktop/WIZARD-pour-Claude-Chat.md"
echo ""
echo "▶️  DÉMARRAGE :"
echo "   → Lance Claude Code CLI"
echo "   → Tape : /wizard"
echo "   → Ou dis : 'active le wizard'"
echo ""
echo "💬 VERSION CHAT :"
echo "   → Glisse le fichier desktop/WIZARD-pour-Claude-Chat.md dans Claude.ai"
echo "   → Dis : 'active le wizard'"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

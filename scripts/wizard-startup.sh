#!/bin/bash
# WIZARD — SessionStart hook
# S'exécute à chaque lancement de Claude Code CLI
# Vérifie l'environnement et alerte sur les nouveautés

WIZARD_DIR="$HOME/.claude/skills/wizard"
LAST_UPDATE_FILE="$HOME/.claude/scripts/.wizard-last-update"
TODAY=$(date +%Y-%m-%d)

# 1. Vérifier si Wizard est installé
if [ ! -f "$WIZARD_DIR/SKILL.md" ]; then
  echo ""
  echo "⚠️  WIZARD non installé — tape \`/wizard\` pour démarrer ton premier projet"
  exit 0
fi

# 2. Vérifier la date de dernière mise à jour
if [ -f "$LAST_UPDATE_FILE" ]; then
  LAST_UPDATE=$(cat "$LAST_UPDATE_FILE")
  DAYS_SINCE=$(( ($(date -d "$TODAY" +%s 2>/dev/null || date -j -f "%Y-%m-%d" "$TODAY" +%s 2>/dev/null) - $(date -d "$LAST_UPDATE" +%s 2>/dev/null || date -j -f "%Y-%m-%d" "$LAST_UPDATE" +%s 2>/dev/null)) / 86400 ))

  if [ "$DAYS_SINCE" -ge 7 ] 2>/dev/null; then
    echo ""
    echo "🧙 WIZARD — Mise à jour disponible (dernière vérif: $LAST_UPDATE)"
    echo "   → Tape \`wizard update\` pour scanner les nouveaux skills et tendances"
  fi
else
  # Première exécution — créer le fichier
  echo "$TODAY" > "$LAST_UPDATE_FILE"
fi

# 3. Scanner les skills installés
SKILLS_COUNT=$(find "$HOME/.claude/skills" -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ')

# 4. Vérifier si un projet Wizard est en cours
if [ -f ".wizard/state.json" ] 2>/dev/null; then
  PHASE=$(grep -o '"phase":"[^"]*"' .wizard/state.json 2>/dev/null | cut -d'"' -f4)
  PROJECT=$(grep -o '"project_name":"[^"]*"' .wizard/state.json 2>/dev/null | cut -d'"' -f4)

  if [ -n "$PROJECT" ] && [ "$PROJECT" != "" ]; then
    echo ""
    echo "🧙 WIZARD — Projet en cours : $PROJECT | Phase : $PHASE"
    echo "   → Tape \`wizard next\` pour continuer"
  fi
fi

# 5. Alerte sécurité si .env non ignoré (dans un projet existant)
if [ -f ".gitignore" ] && [ -f ".env" ]; then
  if ! grep -q "^\.env$" .gitignore 2>/dev/null && ! grep -q "^\.env" .gitignore 2>/dev/null; then
    echo ""
    echo "🔴 ALERTE SÉCURITÉ — .env non ignoré dans ce projet !"
    echo "   → Ajoute \`.env\` à ton .gitignore IMMÉDIATEMENT"
  fi
fi

exit 0

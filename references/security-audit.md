# Security Audit — Vérifications actives par niveau

## Principe

WIZARD ne liste pas seulement des checkboxes. En mode CLI, il exécute les vérifications.
En mode Chat, il donne les commandes exactes avec les résultats attendus.

---

## Déterminer le niveau de sécurité

Défini au cadrage dans `state.json > security_level`.

| Niveau | Quand | Effort |
|--------|-------|--------|
| **standard** | App interne, outil perso, prototype | Minimal — essentiel uniquement |
| **renforcé** | App publique, utilisateurs externes | Modéré — headers, CORS, XSS |
| **strict** | Données sensibles, RGPD, santé, finance | Important — chiffrement, audit log |

---

## Niveau Standard — Le minimum vital

### Checks automatiques (mode CLI) :

```bash
# 1. .env jamais commité
git log --all --full-history -- "*.env" ".env*"
# Résultat non vide = CRITIQUE : purger l'historique git

# 2. .gitignore contient les patterns essentiels
grep -q ".env" .gitignore && echo "OK" || echo "MANQUANT: .env dans .gitignore"
grep -q "node_modules" .gitignore && echo "OK" || echo "MANQUANT: node_modules"

# 3. Scanner les secrets potentiels hardcodés
grep -rn "password\|secret\|api_key\|token" \
  --include="*.ts" --include="*.js" --include="*.py" \
  --exclude-dir=node_modules --exclude-dir=.git \
  | grep -v "process.env\|os.environ\|\.env\|// \|#"

# 4. Vérifier les dépendances vulnérables
npm audit 2>/dev/null || pip audit 2>/dev/null || echo "Audit non disponible"

# 5. HTTPS uniquement (pas de http:// en dur sauf localhost)
grep -rn "http://" \
  --include="*.ts" --include="*.js" --include="*.py" \
  --exclude-dir=node_modules --exclude-dir=.git \
  | grep -v "localhost\|127.0.0.1\|example.com\|// \|#"
```

### Checklist manuelle :

- [ ] Variables d'environnement pour tous les secrets (jamais hardcodé)
- [ ] `.env` dans `.gitignore`
- [ ] `.env.example` existe avec les clés (sans les vraies valeurs)
- [ ] HTTPS en production
- [ ] Validation des inputs côté serveur (Zod, Pydantic, class-validator)
- [ ] Rate limiting sur les endpoints d'authentification
- [ ] Sessions / tokens avec expiration raisonnable
- [ ] `npm audit` ou `pip audit` sans vulnérabilité critique

---

## Niveau Renforcé — App publique

Tout le standard, plus :

### Checks automatiques supplémentaires :

```bash
# 6. Headers de sécurité (si app déployée)
curl -sI https://[URL] | grep -iE "x-frame|x-content-type|strict-transport|content-security-policy"
# Attendus : X-Frame-Options, X-Content-Type-Options, HSTS, CSP

# 7. CORS configuration
grep -rn "cors\|Access-Control-Allow-Origin" \
  --include="*.ts" --include="*.js" --include="*.py" \
  --exclude-dir=node_modules
# Vérifier que ce n'est pas "*" en production

# 8. Dépendances obsolètes
npm outdated 2>/dev/null | head -20
```

### Configuration headers Next.js recommandée :

```javascript
// next.config.js
const securityHeaders = [
  { key: 'X-DNS-Prefetch-Control', value: 'on' },
  { key: 'Strict-Transport-Security', value: 'max-age=63072000; includeSubDomains; preload' },
  { key: 'X-Frame-Options', value: 'SAMEORIGIN' },
  { key: 'X-Content-Type-Options', value: 'nosniff' },
  { key: 'Referrer-Policy', value: 'origin-when-cross-origin' },
  { key: 'Permissions-Policy', value: 'camera=(), microphone=(), geolocation=()' },
  { key: 'Content-Security-Policy', value: "default-src 'self'; script-src 'self' 'unsafe-eval' 'unsafe-inline';" },
];
```

Adapter selon le framework et les domaines autorisés.

### Checklist supplémentaire :

- [ ] Headers CSP configurés (Content Security Policy)
- [ ] CORS restreint aux domaines autorisés (jamais `*` en prod)
- [ ] Protection XSS (sanitization des inputs affichés)
- [ ] Protection CSRF (tokens ou SameSite cookies)
- [ ] Rate limiting global (pas seulement auth)
- [ ] Logs des actions sensibles (login, changement mot de passe, suppression)
- [ ] 2FA optionnel pour les utilisateurs
- [ ] Dépendances à jour (pas de CVE critique ouverte)
- [ ] GitHub Dependabot activé sur le repo

---

## Niveau Strict — RGPD / données sensibles

Tout le renforcé, plus :

### Checklist RGPD :

- [ ] **Consentement cookies** conforme (opt-in explicite, pas de pre-check)
- [ ] **Politique de confidentialité** accessible et à jour
- [ ] **Droit à l'oubli** implémenté (endpoint de suppression complète des données)
- [ ] **Export des données** utilisateur (GDPR data portability)
- [ ] **Chiffrement au repos** des données sensibles (AES-256 ou équivalent)
- [ ] **Chiffrement en transit** TLS 1.2+ minimum
- [ ] **Politique de rétention** documentée
- [ ] **Audit log** de tous les accès aux données sensibles
- [ ] **RBAC** — contrôle d'accès par rôle sur les données sensibles
- [ ] Données sensibles jamais dans les logs ni dans les URLs

### Architecture données sensibles :

```
Données sensibles
  → Chiffrées au repos (DB encrypted column ou vault)
  → Jamais dans les logs applicatifs
  → Jamais dans les URLs (paramètres GET)
  → Accès restreint par rôle (RBAC + RLS Supabase)
  → Suppression complète sur demande (CASCADE + purge)
  → Audit trail de chaque accès
```

---

## Intégrations sécurité recommandées

| Outil | Quand proposer | Ce qu'il fait |
|-------|---------------|---------------|
| **Sentry** | Toujours en prod | Monitoring erreurs + alertes |
| **GitHub Dependabot** | Tout projet GitHub | PRs auto pour deps vulnérables |
| **Snyk** | Projets avec beaucoup de deps | Scan vulnérabilités avancé |
| **Upstash Redis** | Rate limiting avancé | Compteurs distribués |
| **Vault (HashiCorp)** | Niveau strict | Gestion centralisée des secrets |

---

## Format du rapport de sécurité

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔒 WIZARD — Audit Sécurité

Niveau : [standard/renforcé/strict]
Mode : [CLI — vérifications exécutées / Chat — vérifications manuelles]

✅ PASSÉ :
- [check 1]
- [check 2]

⚠️ AVERTISSEMENT :
- [problème non critique — action recommandée]

🔴 CRITIQUE :
- [vulnérabilité à corriger IMMÉDIATEMENT]

📋 ACTIONS PAR PRIORITÉ :
1. [action urgente]
2. [action importante]
3. [action recommandée]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

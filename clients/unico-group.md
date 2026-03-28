# Unico Group — Profil client complet

## Groupe Unico Consult

**Holding belge multi-sociétés**
- **Siège** : Hippokrateslaan 4/001, Belgique
- **GM** : Otman Hssinoui (ohs@unico-consult.be)
- **Équipe directe** :
  - Farid Saouti — Admin / Juridique / RH
  - Jamal El Kadaoui — Comptabilité / Commandes
  - Mohamed Hssinoui — Opérationnel
  - Samira Hssinoui — Maison'Net
- **Outils actuels** : Outlook, OneDrive, SD Worx (salaires), Codabox (factures électroniques), WhatsApp

---

## Sociétés du groupe

### 🏢 Unico Consult
- **Type** : Holding / Consulting
- **Rôle** : Tête de groupe, coordination inter-sociétés
- **Besoins digitaux** : Dashboard groupe, reporting consolidé

### 🧹 Amethys Clean Services
- **Secteur** : Nettoyage professionnel
- **Besoins digitaux** : Gestion planning agents, rapports d'intervention, facturation clients

### 🏠 Maison'Net / La Cense Titres-Services
- **Secteur** : Titres-services (nettoyage domicile)
- **Contact** : Samira Hssinoui
- **Besoins digitaux** : Gestion aides-ménagères, planning clients, titres-services, conformité SD Worx

### 🚛 CI&T Express
- **Secteur** : Transport / Logistique
- **Besoins digitaux** : Suivi livraisons, gestion chauffeurs, bons de livraison

### 📊 LOGICON
- **Secteur** : Consulting / Logistique
- **Besoins digitaux** : Gestion de projets, suivi missions consultants

### 🌱 MobyGreen
- **Secteur** : [À compléter — mobilité verte ?]
- **Besoins digitaux** : [À compléter]

### 🔧 Acerty
- **Secteur** : [À compléter]
- **Besoins digitaux** : [À compléter]

### 💼 Nassim Consult
- **Secteur** : Consulting
- **Besoins digitaux** : [À compléter]

### 🏗️ Astra Management
- **Secteur** : Management / Immobilier
- **Besoins digitaux** : [À compléter]

---

## Projets en cours et à venir

### ✅ UnicoHub (en développement)
- **Description** : App de communication interne tout-en-un — remplace Outlook + OneDrive + WhatsApp
- **Stack** : Next.js 14 + Express + Socket.io + PostgreSQL + Redis
- **Fonctionnalités** : Chat groupes + DM + fils par dossier, fichiers, tâches kanban, recherche globale
- **Phase actuelle** : Développement backend (étapes 1-12 sur 22)
- **Repo** : À définir
- **Design** : Sidebar mauve foncé (#2d1b4e → #1e1145), accent violet (#7c3aed), bg blanc cassé (#faf8ff)
- **Phase 2** : Communication avec clients externes + appels audio/vidéo + mobile

### 🔲 À développer (idées / backlog)
- Site vitrine groupe Unico Consult
- Portail RH interne (SD Worx intégré)
- App suivi interventions Amethys / Maison'Net
- Dashboard reporting consolidé groupe
- Site vitrine ou app pour Acerty
- Site vitrine ou app pour MobyGreen
- App gestion transport CI&T Express

---

## Conventions techniques Unico

### Stack par type de projet

| Type de projet | Stack recommandée |
|---------------|-------------------|
| **App interne SaaS** | Next.js 15 + Supabase + Vercel |
| **Site vitrine** | Next.js 15 ou Astro + Vercel |
| **App avec temps réel** | Next.js + Express + Socket.io + Railway |
| **Mobile** | Expo (React Native) + Supabase |
| **Dashboard admin** | Next.js + Supabase + Recharts |

### GitHub
- Organisation : **amine-hs09** (compte Otman)
- Convention repos : `[société]-[type]` → ex: `unicohub-app`, `maisonnet-site`, `acerty-dashboard`
- Branche principale : `main`
- Déploiement auto sur push `main`

### Design — Identité Unico
- **Style** : Impressionnant mais clair ("wa3ar" mais pas perdu)
- **Approche** : Professionnel, moderne, pas générique
- **Police** : Inter (clean, pro)
- **Palette groupe** :
  - Mauve/violet pour les apps internes Unico
  - Palette propre par société pour les sites externes
- **Règle** : Toujours demander la charte de la société concernée avant de coder l'UI

### Sécurité
- **Niveau par défaut** : Renforcé (apps avec données employés/clients)
- **RGPD** : Obligatoire — données employés, titres-services, clients
- **Auth** : Supabase Auth (email + rôles) pour les apps internes
- **Rôles types** : admin (Otman) / manager / member / viewer

---

## Préférences Otman

- **Langue** : Français (parfois expressions arabes — "wa3ar" = impressionnant)
- **UI** : Beau et impressionnant, mais intuitif. Pas de confusion.
- **Approche** : Direct, pas de blabla. Montre le résultat.
- **Décisions** : Otman valide les choix de stack et design
- **GitHub** : Gestion automatique par Wizard (Otman ne veut pas gérer git manuellement)

---

## Commande `wizard unico`

Quand l'utilisateur tape "wizard unico" :

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🧙 WIZARD — Groupe Unico Consult

👤 GM : Otman Hssinoui
🏢 9 sociétés : Unico Consult, Amethys, Maison'Net,
   CI&T Express, LOGICON, MobyGreen, Acerty,
   Nassim Consult, Astra Management

📦 PROJETS ACTIFS :
→ UnicoHub        En développement — Phase [X]/22
→ [autres projets si state.json présents]

🔲 BACKLOG :
→ Site vitrine Unico Consult
→ App Amethys / Maison'Net
→ Dashboard reporting groupe
→ [autres idées]

Sur quel projet on travaille aujourd'hui ?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

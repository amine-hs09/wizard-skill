# DB Architect — Design de bases de données

## Procédure de design

### Étape 1 — Identifier les entités

Questions à poser :

1. **Quelles sont les entités principales ?** (users, products, orders, messages, etc.)
2. **Quelles relations entre elles ?** (1-1, 1-N, N-N)
3. **Données sensibles ?** (emails, téléphones, paiements → chiffrement)
4. **Volumes attendus ?** (centaines, milliers, millions de lignes)
5. **Patterns d'accès ?** (lecture lourde, écriture lourde, temps réel)

### Étape 2 — Choisir le type de DB

Basé sur le projet et la stack choisie :

| Besoin | DB recommandée | Pourquoi |
|--------|---------------|----------|
| SaaS classique | PostgreSQL (Supabase/Neon) | Relationnel, RLS, realtime |
| API rapide, schema flexible | PostgreSQL ou MongoDB | Selon la complexité relationnelle |
| Recherche full-text | PostgreSQL (pg_trgm) ou Meilisearch | PG suffit souvent |
| Vector / embeddings IA | PostgreSQL + pgvector | Intégré, pas de service externe |
| Cache / sessions | Redis (Upstash) | Ultra-rapide, TTL natif |
| Analytics | DuckDB ou ClickHouse | Colonnes, agrégations rapides |
| Edge / embarqué | SQLite (Turso/Libsql) | Léger, local-first |

**Toujours vérifier les tendances actuelles** via web search avant de recommander
si l'utilisateur n'a pas de préférence.

### Étape 3 — Schéma SQL

Fournir le schéma complet avec :
- Tables et colonnes avec types précis
- Clés primaires (UUID v7 recommandé pour le tri chronologique)
- Clés étrangères avec ON DELETE approprié
- Index sur les colonnes fréquemment requêtées
- Timestamps (`created_at`, `updated_at`) sur toutes les tables
- Soft delete (`deleted_at`) si pertinent

**Template de base :**

```sql
-- Toujours commencer par la table users
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT UNIQUE NOT NULL,
  name TEXT,
  avatar_url TEXT,
  role TEXT NOT NULL DEFAULT 'user' CHECK (role IN ('user', 'admin')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Index email pour login rapide
CREATE INDEX idx_users_email ON users(email);

-- Trigger auto-update du updated_at
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_updated_at
  BEFORE UPDATE ON users
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();
```

Adapter ce template à chaque table du projet.

### Étape 4 — Row Level Security (si Supabase/PostgreSQL)

Pour chaque table, définir les politiques RLS :

```sql
-- Activer RLS
ALTER TABLE [table] ENABLE ROW LEVEL SECURITY;

-- Patterns courants :

-- Lecture : l'utilisateur voit ses propres données
CREATE POLICY "Users read own data" ON [table]
  FOR SELECT USING (auth.uid() = user_id);

-- Écriture : l'utilisateur modifie ses propres données
CREATE POLICY "Users update own data" ON [table]
  FOR UPDATE USING (auth.uid() = user_id);

-- Insertion : l'utilisateur crée pour lui-même
CREATE POLICY "Users insert own data" ON [table]
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Admin : accès total
CREATE POLICY "Admins full access" ON [table]
  FOR ALL USING (
    EXISTS (SELECT 1 FROM users WHERE id = auth.uid() AND role = 'admin')
  );

-- Public : lecture pour tous (si données publiques)
CREATE POLICY "Public read" ON [table]
  FOR SELECT USING (is_public = true);
```

### Étape 5 — Seed data

Fournir un script de données de test :

```sql
-- Seed data pour développement
INSERT INTO users (id, email, name, role) VALUES
  ('00000000-0000-0000-0000-000000000001', 'admin@test.com', 'Admin Test', 'admin'),
  ('00000000-0000-0000-0000-000000000002', 'user@test.com', 'User Test', 'user');

-- Adapter selon les tables du projet
```

### Étape 6 — Migrations

Organiser les migrations de manière incrémentale :

```
migrations/
├── 001_create_users.sql
├── 002_create_products.sql
├── 003_add_orders.sql
└── 004_add_indexes.sql
```

En mode CLI : créer les fichiers de migration directement.
En mode Chat : fournir le SQL à copier dans le SQL Editor.

---

## Patterns avancés (premium)

### Multi-tenant

```sql
-- Ajouter tenant_id à chaque table
ALTER TABLE [table] ADD COLUMN tenant_id UUID NOT NULL REFERENCES tenants(id);

-- RLS par tenant
CREATE POLICY "Tenant isolation" ON [table]
  FOR ALL USING (
    tenant_id = (SELECT tenant_id FROM users WHERE id = auth.uid())
  );
```

### Audit trail

```sql
CREATE TABLE audit_log (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id),
  action TEXT NOT NULL, -- 'create', 'update', 'delete'
  table_name TEXT NOT NULL,
  record_id UUID NOT NULL,
  old_data JSONB,
  new_data JSONB,
  ip_address INET,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Trigger automatique (à attacher à chaque table sensible)
```

### Soft delete global

```sql
-- Ajouter à chaque table concernée
ALTER TABLE [table] ADD COLUMN deleted_at TIMESTAMPTZ;

-- Modifier les policies pour exclure les supprimés
CREATE POLICY "Exclude deleted" ON [table]
  FOR SELECT USING (deleted_at IS NULL);
```

---

## Format de présentation du schéma

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🗄️ WIZARD — Architecture DB

Tables : [nombre]
Relations : [liste des relations clés]
RLS : [activé/désactivé]
Migrations : [nombre de fichiers]

[Schéma SQL complet ci-dessous]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

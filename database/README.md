# 公開用PostgreSQLの準備

`schema.sql` はテーブルを作成し、`import-data.sql` はリポジトリ直下の食品CSVを投入します。

Neonでデータベースを作成した後、接続文字列を一時的な環境変数へ設定し、リポジトリのルートで次を実行します。

```bash
psql "$DATABASE_URL" -f database/schema.sql
psql "$DATABASE_URL" -f database/import-data.sql
```

`import-data.sql` は既存の `foods` と `food_name` を一度空にしてから再投入します。`users` は削除しません。

RenderにはNeonの接続情報を次の形式で登録します。

- `BALANCECHECKER_DB_URL`: `jdbc:postgresql://ホスト名/データベース名?sslmode=require`
- `BALANCECHECKER_DB_USER`: Neonのユーザー名
- `BALANCECHECKER_DB_PASSWORD`: Neonのパスワード

秘密情報をGitへ追加しないでください。

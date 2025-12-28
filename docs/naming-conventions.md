# Naming Conventions

## File names

- Use `kebab-case` for file names
  - ✅ `national-records.sql`
  - ❌ `NationalRecords.sql`

## SQL style

- Table and column names in `snake_case`
- Named parameters are written in `UPPERCASE` (e.g. `:YEAR`)

```sql
SELECT *
FROM   competitions c
WHERE  Year(c.start_date) = :YEAR
       AND c.country_id = "Hungary"
```

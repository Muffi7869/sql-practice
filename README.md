# sql-practice

sql practice on a small hospital database (departments, doctors, patients, appointments, prescriptions). all made up data. written for sqlite but almost everything runs on postgres too.

```
sqlite3 hospital.db < schema/01_schema.sql
sqlite3 hospital.db < schema/02_seed.sql
sqlite3 hospital.db < queries/03_aggregation.sql
```

## queries

1. basics - filtering, sorting, case, coalesce
2. joins - inner/left/self joins, anti joins
3. aggregation - group by, having, rates and percentages
4. subqueries + ctes - correlated subqueries, exists, chained and recursive ctes
5. window functions - rank, running totals, lag, moving averages, ntile
6. views + updates - views, transactions, upserts, deletes

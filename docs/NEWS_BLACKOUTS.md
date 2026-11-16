# News Blackouts

The EA reads `MEMO_NewsBlackouts.csv` from `MQL5/Files`.

CSV format:

```csv
start,end,impact,currency,title
2026.06.17 15:30,2026.06.17 15:45,High,USD,FOMC statement
```

Columns:

- `start`: broker/server time.
- `end`: broker/server time.
- `impact`: `High`, `Medium`, or blank.
- `currency`: `USD`, `XAU`, `XAG`, or `*`.
- `title`: free text for logs.

The EA expands each event by `InpNewsMinutesBefore` and `InpNewsMinutesAfter`.

External infrastructure can update this CSV every minute. The EA reloads it automatically.

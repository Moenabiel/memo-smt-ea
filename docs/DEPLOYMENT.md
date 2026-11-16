# Deployment

## Install Into MetaTrader 5

Run PowerShell:

```powershell
.\scripts\install-mt5.ps1 -TerminalDataPath "$env:APPDATA\MetaQuotes\Terminal\<terminal-id>"
```

Or copy manually:

- `MQL5/Experts/MEMO/MEMO_XAU_XAG_SMT_EA.mq5` to `<MT5 Data Folder>/MQL5/Experts/MEMO/`
- `MQL5/Include/MEMO/` to `<MT5 Data Folder>/MQL5/Include/MEMO/`
- `config/MEMO_NewsBlackouts.example.csv` to `<MT5 Data Folder>/MQL5/Files/MEMO_NewsBlackouts.csv`

Open MetaEditor, compile `MEMO_XAU_XAG_SMT_EA.mq5`, then attach it to either XAUUSD or XAGUSD.

## Required Chart/Broker Setup

- Both `XAUUSD` and `XAGUSD` must exist in Market Watch.
- If your broker uses suffixes such as `XAUUSDm`, set `InpSymbolA` and `InpSymbolB` accordingly.
- Keep AutoTrading disabled until strategy tester and demo forward tests pass.
- Set broker-time sessions to match the server clock shown in Market Watch.

## Files Written At Runtime

The EA writes these in `MQL5/Files`:

- `MEMO_SMT_decision_log.csv`
- `MEMO_SMT_setup_history.csv`

These files are suitable for audit, optimization review, and external MCP/alert bridges.

## Live Checklist

1. Compile cleanly in MetaEditor.
2. Run visual backtests on XAUUSD and XAGUSD.
3. Confirm session times are broker-time correct.
4. Confirm spread, stops level, tick value, and lot sizing.
5. Forward test on demo for at least one market week.
6. Enable `InpAllowLiveTrading=true` only after forward validation.

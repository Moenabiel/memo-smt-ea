# MEMO XAU/XAG SMT Expert Advisor

![MQL5](https://img.shields.io/badge/MQL5-43E6D0?style=flat-square)
![MetaTrader 5](https://img.shields.io/badge/MetaTrader%205-43E6D0?style=flat-square)
![Research](https://img.shields.io/badge/status-research%20%2F%20not%20live-A6FF4D?style=flat-square)
![Live trading off](https://img.shields.io/badge/InpAllowLiveTrading-false-8a9a9a?style=flat-square)
![MIT](https://img.shields.io/badge/license-MIT-8a9a9a?style=flat-square)

Production-oriented MetaTrader 5 Expert Advisor for **XAUUSD/XAGUSD Smart Money Technique
divergence trading** — written as composable engines behind a single entry point, with every
gate able to veto a trade.

> **The one idea:** the EA trades only the instrument that *refuses* the correlated liquidity
> sweep. If gold sweeps and silver refuses, silver is the candidate. If silver sweeps and gold
> refuses, gold is the candidate. If both sweep, neither sweeps, correlation fails, the session
> is disabled, or confirmation is missing — **no trade is allowed**.

---

## Portfolio showcase

![MEMO XAU/XAG SMT EA architecture](docs/architecture.svg)

Twelve ordered steps from liquidity map to execution. Green-bordered steps are **veto gates** —
they can only block, never force a trade.

**What this demonstrates**

- **Systems decomposition in a language most people write monoliths in:** 9 analysis engines,
  6 control managers, 3 core types — all swappable behind `MEMO_XAU_XAG_SMT_EA.mq5`.
- **Risk logic as a first-class citizen:** dynamic sizing, drawdown limits, trade-count limits,
  loss shutdown and an emergency stop are all separate from signal logic.
- **Honest research hygiene:** live trading is off by default; the strategy tester still runs
  signals, logs and setup history, so behaviour can be inspected before money is involved.

### The module map

| Layer | Modules |
|---|---|
| **Core** | `MarketData.mqh` · `Settings.mqh` · `Types.mqh` |
| **Engines** | `LiquidityEngine` · `SMTDetectionEngine` · `CorrelationEngine` · `DisplacementEngine` · `MarketStructureEngine` · `FVGEngine` · `OrderBlockEngine` · `PremiumDiscountEngine` · `MarketRegimeEngine` · `ScoringEngine` |
| **Managers** | `SymbolManager` · `SessionManager` · `RiskManager` · `TradeManager` · `StatisticsManager` · `VisualizationManager` · `LoggingManager` · `NewsFilter` |
| **Entry point** | `MQL5/Experts/MEMO/MEMO_XAU_XAG_SMT_EA.mq5` |

---

## Trading sequence

1. Build XAU/XAG liquidity maps
2. Detect tier 1 or tier 2 SMT
3. Select only the refusing instrument
4. Validate rolling correlation
5. Apply news / session / regime gates
6. Require displacement with FVG creation
7. Require MSS or CHOCH
8. Validate premium / discount
9. Require FVG or order-block retest
10. Score the setup
11. Apply drawdown, trade-count, loss and emergency controls
12. Execute and manage the position

---

## Install

```powershell
# copies the EA + include tree into the MetaTrader 5 data folder
pwsh -File scripts/install-mt5.ps1
```

Then in MetaTrader 5: open the strategy tester, pick `MEMO_XAU_XAG_SMT_EA`, and load the
parameter set from `config/MEMO_XAU_XAG_SMT_EA.set`.
News blackouts are supplied as a CSV — `config/MEMO_NewsBlackouts.example.csv`.

## Documentation

| Document | Purpose |
|---|---|
| [`docs/DEPLOYMENT.md`](docs/DEPLOYMENT.md) | Broker symbol validation, spread testing, forward-demo steps |
| [`docs/NEWS_BLACKOUTS.md`](docs/NEWS_BLACKOUTS.md) | Blackout calendar format and maintenance |
| [`docs/OPTIMIZATION.md`](docs/OPTIMIZATION.md) | Which inputs to optimise, walk-forward protocol, robustness checks |

---

## Status — honest labels

**Research.** The EA is feature-complete and compiles, but **no live-performance claim is made
here**: there is no published backtest, no broker log and no live account record in this
repository. `InpAllowLiveTrading` ships `false`. The correct next step is the walk-forward
protocol in `docs/OPTIMIZATION.md` — train 3–6 months, forward-test 1 month, stress the
high-volatility news periods — and only then a forward demo.

Any parameter set that only performs during one isolated month should be rejected.

## Security note

The source folder previously exposed a Telegram bot token. It was removed before publication;
**rotate that token** before reusing any connected bot infrastructure.

## Licence

MIT — see [`LICENSE`](LICENSE).

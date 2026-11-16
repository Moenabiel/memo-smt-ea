# MEMO XAU/XAG SMT Expert Advisor

Production-oriented MetaTrader 5 Expert Advisor for XAUUSD/XAGUSD Smart Money Technique divergence trading.

The EA trades only the instrument that refuses the correlated liquidity sweep. If gold sweeps and silver refuses, silver is the candidate. If silver sweeps and gold refuses, gold is the candidate. If both sweep, neither sweeps, correlation fails, session is disabled, or confirmation is missing, no trade is allowed.

## Architecture

```text
MQL5/
  Experts/MEMO/MEMO_XAU_XAG_SMT_EA.mq5
  Include/MEMO/Core/
  Include/MEMO/Engines/
  Include/MEMO/Managers/
config/
  MEMO_XAU_XAG_SMT_EA.set
  MEMO_NewsBlackouts.example.csv
scripts/
  install-mt5.ps1
docs/
  DEPLOYMENT.md
  NEWS_BLACKOUTS.md
  OPTIMIZATION.md
```

## Trading Sequence

1. Build XAU/XAG liquidity maps.
2. Detect tier 1 or tier 2 SMT.
3. Select only the refusing instrument.
4. Validate rolling correlation.
5. Apply news/session/regime gates.
6. Require displacement with FVG creation.
7. Require MSS or CHOCH.
8. Validate premium/discount.
9. Require FVG or order-block retest.
10. Score the setup.
11. Apply drawdown, trade count, loss, and emergency controls.
12. Execute and manage the position.

## Implemented Modules

- `SymbolManager`: broker symbol metadata, volume constraints, symbol gating.
- `SessionManager`: broker-time Asia/London/New York windows and major liquidity windows.
- `LiquidityEngine`: previous day/week, session, New York opening range, and sweep detection.
- `SMTDetectionEngine`: tiered SMT, tier-3 confirmation, cascade scoring.
- `CorrelationEngine`: rolling return correlation gate.
- `DisplacementEngine`: impulsive candle, ATR/body ratio, FVG creation.
- `MarketStructureEngine`: MSS/CHOCH swing break detection.
- `FVGEngine`: three-candle fair value gaps and retests.
- `OrderBlockEngine`: recent institutional candle zones and retests.
- `PremiumDiscountEngine`: dealing range premium/discount validation.
- `MarketRegimeEngine`: trend/range/expansion/reversal/volatility classification.
- `ScoringEngine`: transparent confidence breakdown.
- `RiskManager`: dynamic risk, drawdown limits, trade limits, loss shutdown.
- `TradeManager`: execution, break-even, partials, ATR/structure/FVG trailing.
- `StatisticsManager`: setup journal and 180-day performance stats.
- `VisualizationManager`: chart levels, zones, entries, exits, and dashboard.
- `LoggingManager`: CSV decision log and Experts-tab trace.

## Safety Defaults

`InpAllowLiveTrading` defaults to `false`. Compile and backtest first, then explicitly enable live trading only after broker-symbol validation, spread testing, and forward demo testing.

The source folder logs previously exposed a Telegram bot token. Rotate that token before reusing any connected bot infrastructure.

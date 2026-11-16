# Optimization Guide

## Priority Inputs

Optimize these first:

- `InpMinimumCorrelation`
- `InpSweepLookbackBars`
- `InpSweepBufferPoints`
- `InpMinimumDisplacementPoints`
- `InpDisplacementATRMultiple`
- `InpMinimumBodyRatio`
- `InpStructureLookbackBars`
- `InpMinimumFVGPoints`
- `InpEntrySensitivityPoints`
- `InpConfidenceThreshold`
- `InpTP1RMultiple`
- `InpTP2RMultiple`
- `InpATRTrailingMultiple`

## Walk Forward

Use at least three segments:

- Train: 3-6 months.
- Forward: 1 month.
- Stress: high-volatility news periods.

Do not optimize risk percent first. Optimize signal quality and exit behavior, then size conservatively.

## Robustness Checks

- Run XAUUSD and XAGUSD with the same settings.
- Check spread sensitivity.
- Check London-only, New-York-only, and combined windows.
- Check low-volatility and high-volatility periods separately.
- Reject parameter sets that only perform during one isolated month.

## Production Notes

Keep `InpAllowLiveTrading=false` for optimization. The strategy tester can still evaluate signals, logs, and setup history without risking accidental live execution.

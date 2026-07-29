# Conditional Tests: `DisplayModeManager`

## Conditional Tests: `DisplayModeManagerSegmented`

| showIcon | showLabel | showSelectedIcon | selectedIconReplaceMainIcon | Result: |
| -------- | ------- | -------- | ------- | ------- |
| 0 | 0 | 0 | 0 | *e001* |
| 0 | 0 | 0 | 1 | *e001* |
| 0 | 0 | 1 | 0 | *e001* |
| 0 | 0 | 1 | 1 | *e001* |
| 0 | 1 | 0 | 0 | **pass** |
| 0 | 1 | 0 | 1 | *e003* |
| 0 | 1 | 1 | 0 | **pass** |
| 0 | 1 | 1 | 1 | *e004* |
| 1 | 0 | 0 | 0 | **pass** |
| 1 | 0 | 0 | 1 | *e003* |
| 1 | 0 | 1 | 0 | **pass** |
| 1 | 0 | 1 | 1 | *e002* |
| 1 | 1 | 0 | 0 | **pass** |
| 1 | 1 | 0 | 1 | *e003* |
| 1 | 1 | 1 | 0 | **pass** |
| 1 | 1 | 1 | 1 | **pass** |

> "pass": means the widget will work correctly, based on the parameters used.

## Conditional Tests: `DisplayModeManagerBottomsheet`


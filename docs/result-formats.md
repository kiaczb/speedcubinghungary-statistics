# Result Formats

_**Note**: You can use the_ `wca_statistics_time_format(time_result, event_id, result_type)` _(explained in the `wca-information.md`) function to format the results properly_

## Time-based events

Time-based events (e.g., 3x3x3 Cube) store results as `centiseconds` (1/100 of a second).
| Stored value | Human-readable |
| ------------ | -------------- |
| 1234 | 12.34 seconds |
| 854 | 8.54 seconds |

## Fewest moves (FMC)

Fewest Moves events store the number of moves as an integer.
| Stored value | Human-readable |
| ------------ | -------------- |
| 32 | 32 moves |
| 25 | 25 moves |

## Multi-Blind

Multi-Blind uses a special encoded integer format. It stores the time as well as the number of cubes attempted and solved (It is designed so that a lower value means a better result.).

A result `0DDTTTTTMM` encodes the following information:

      timeInSeconds = TTTTT (99999 means unknown)
      difference    = 99 - DD
      missed        = MM
      solved        = difference + missed
      attempted     = solved + missed

##### Example:

`380350302`

- `timeInSeconds = 03503 (which is 58:23)`
- `difference: = 99-38 = 61`
- `missed = 02`
- `solved = 61 + 2 = 63`
- `attempted = 63 + 2 = 65`

Now we can build our result:
`solved/attempted (timeInSeconds)`

So we get `63/65 (58:23)` (The time needs to be converted.)

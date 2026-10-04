# montyhall

An R package that builds and plays the Monty Hall problem, and simulates many games to compare
the stay and switch strategies.

Course exercise in R package structure — function documentation with roxygen2, a `NAMESPACE`,
generated `man/` pages, and a declared dependency. The statistics are a known result; the point
of the exercise is the packaging.

## Install

```r
# install.packages("devtools")
devtools::install_github("t00th-blip/montyhall")
library(montyhall)
```

## The game, one step at a time

```r
game <- create_game()      # one car, two goats, randomly assigned to three doors
my.pick <- select_door()   # contestant's first choice
opened <- open_goat_door(game, my.pick)   # host opens a goat door, never the pick

# the decision
final.stay   <- change_door(stay = TRUE,  opened.door = opened, a.pick = my.pick)
final.switch <- change_door(stay = FALSE, opened.door = opened, a.pick = my.pick)

determine_winner(final.stay,   game)
determine_winner(final.switch, game)
```

## Simulate

```r
play_game()            # one full game, returns the outcome under both strategies
play_n_games(n = 1000) # tabulates win rates for stay vs. switch
```

Over many games the switch strategy wins about twice as often as staying. `play_n_games()`
returns the proportions so you can see the result converge rather than take it on faith.

## Functions

| Function | What it does |
|---|---|
| `create_game()` | Returns a length-3 vector assigning one car and two goats to the doors |
| `select_door()` | Returns the contestant's initial door choice |
| `open_goat_door(game, a.pick)` | Host opens a goat door that isn't the contestant's pick |
| `change_door(stay, opened.door, a.pick)` | Returns the final pick under the stay or switch strategy |
| `determine_winner(final.pick, game)` | Returns whether the final pick won the car |
| `play_game()` | Plays one complete game and reports outcomes for both strategies |
| `play_n_games(n = 100)` | Simulates `n` games and summarizes win rates by strategy |

Each is documented in `man/`; `?play_n_games` works after install.

## Built with

R, `dplyr`, and roxygen2. Written for PAF 514 at Arizona State University.

Part of a portfolio at [github.com/t00th-blip/Portfolio](https://github.com/t00th-blip/Portfolio).

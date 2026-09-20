#' @title
#'   Create a new Monty Hall Problem game.
#'
#' @description
#'   `create_game()` generates a new game that consists of two doors 
#'   with goats behind them, and one with a car.
#'
#' @details
#'   The game setup replicates the game on the TV show "Let's
#'   Make a Deal" where there are three doors for a contestant
#'   to choose from, one of which has a car behind it and two 
#'   have goats. The contestant selects a door, then the host
#'   opens a door to reveal a goat, and then the contestant is
#'   given an opportunity to stay with their original selection
#'   or switch to the other unopened door. There was a famous 
#'   debate about whether it was optimal to stay or switch when
#'   given the option to switch, so this simulation was created
#'   to test both strategies. 
#'
#' @param ... no arguments are used by the function.
#' 
#' @return The function returns a length 3 character vector
#'   indicating the positions of goats and the car.
#'
#' @examples
#'   create_game()
#'
#' @export
create_game <- function()
{
    a.game <- sample( x=c("goat","goat","car"), size=3, replace=F )
    return( a.game )
} 



#' @title
#'   Contestant selects a door.
#'
#' @description
#'   `select_door()` randomly picks one of the three doors as the
#'   contestant's first guess.
#'
#' @details
#'   The contestant picks before the host opens anything, so it is
#'   just a guess. There is a 1 in 3 chance of picking the car.
#'
#' @param ... no arguments are used by the function.
#'
#' @return The function returns a number between 1 and 3 indicating
#'   the door the contestant picked.
#'
#' @examples
#'   select_door()
#'
#' @export
select_door <- function( )
{
  doors <- c(1,2,3) 
  a.pick <- sample( doors, size=1 )
  return( a.pick )  # number between 1 and 3
}



#' @title
#'   Host opens a goat door.
#'
#' @description
#'   `open_goat_door()` opens one of the doors the contestant did not
#'   pick to reveal a goat.
#'
#' @details
#'   The host never opens the car door or the contestant's door. If
#'   the contestant picked the car he opens either goat door, and if
#'   they picked a goat there is only one left to open.
#'
#' @param game a length 3 character vector from `create_game()` with
#'   "goat", "goat", and "car" in a random order.
#' @param a.pick a number between 1 and 3 from `select_door()`
#'   giving the door the contestant picked.
#'
#' @return The function returns a number between 1 and 3 indicating
#'   the door the host opened.
#'
#' @examples
#'   this.game <- create_game()
#'   my.initial.pick <- select_door()
#'   open_goat_door( this.game, my.initial.pick )
#'
#' @export
open_goat_door <- function( game, a.pick )
{
   doors <- c(1,2,3)
   # if contestant selected car,
   # randomly select one of two goats 
   if( game[ a.pick ] == "car" )
   { 
     goat.doors <- doors[ game != "car" ] 
     opened.door <- sample( goat.doors, size=1 )
   }
   if( game[ a.pick ] == "goat" )
   { 
     opened.door <- doors[ game != "car" & doors != a.pick ] 
   }
   return( opened.door ) # number between 1 and 3
}



#' @title
#'   Contestant stays or switches doors.
#'
#' @description
#'   `change_door()` returns the contestant's final pick after they
#'   decide to stay with their first door or switch to the other
#'   closed door.
#'
#' @details
#'   Two doors are still closed after the host reveals a goat. Staying
#'   keeps the first pick, and switching moves to the other closed
#'   door.
#'
#' @param stay a logical value for the strategy. `T` stays with the
#'   first pick and `F` switches to the other closed door.
#' @param opened.door a number between 1 and 3 from
#'   `open_goat_door()` giving the goat door the host opened.
#' @param a.pick a number between 1 and 3 from `select_door()`
#'   giving the contestant's first pick.
#'
#' @return The function returns a number between 1 and 3 indicating
#'   the contestant's final pick.
#'
#' @examples
#'   this.game <- create_game()
#'   my.initial.pick <- select_door()
#'   opened.door <- open_goat_door( this.game, my.initial.pick )
#'
#'   change_door( stay=T, opened.door, my.initial.pick )
#'   change_door( stay=F, opened.door, my.initial.pick )
#'
#' @export
change_door <- function( stay=T, opened.door, a.pick )
{
   doors <- c(1,2,3) 
   
   if( stay )
   {
     final.pick <- a.pick
   }
   if( ! stay )
   {
     final.pick <- doors[ doors != opened.door & doors != a.pick ] 
   }
  
   return( final.pick )  # number between 1 and 3
}



#' @title
#'   Determine if the contestant won.
#'
#' @description
#'   `determine_winner()` checks the contestant's final door and
#'   reports whether they won the car or got a goat.
#'
#' @details
#'   The contestant wins if the car is behind their final door and
#'   loses if a goat is. The same function scores the stay pick and
#'   the switch pick.
#'
#' @param final.pick a number between 1 and 3 from `change_door()`
#'   giving the contestant's final door.
#' @param game a length 3 character vector from `create_game()` with
#'   "goat", "goat", and "car" in a random order.
#'
#' @return The function returns a length 1 character vector, "WIN" if
#'   the car was behind the final door and "LOSE" if a goat was.
#'
#' @examples
#'   this.game <- create_game()
#'   my.initial.pick <- select_door()
#'   opened.door <- open_goat_door( this.game, my.initial.pick )
#'   my.final.pick <- change_door( stay=T, opened.door, my.initial.pick )
#'
#'   determine_winner( my.final.pick, this.game )
#'
#' @export
determine_winner <- function( final.pick, game )
{
   if( game[ final.pick ] == "car" )
   {
      return( "WIN" )
   }
   if( game[ final.pick ] == "goat" )
   {
      return( "LOSE" )
   }
}





#' @title
#'   Play one full game with both strategies.
#'
#' @description
#'   `play_game()` plays a whole game start to finish and reports the
#'   outcome for staying and the outcome for switching.
#'
#' @details
#'   The function runs all the steps in order and scores the final
#'   pick for staying and for switching. Both use the same game and
#'   the same first pick, so only one of them can win.
#'
#' @param ... no arguments are used by the function.
#'
#' @return The function returns a data frame with 2 rows and 2
#'   columns. The `strategy` column is "stay" and "switch" and the
#'   `outcome` column is the "WIN" or "LOSE" result for each one.
#'
#' @examples
#'   play_game()
#'
#' @export
play_game <- function( )
{
  new.game <- create_game()
  first.pick <- select_door()
  opened.door <- open_goat_door( new.game, first.pick )

  final.pick.stay <- change_door( stay=T, opened.door, first.pick )
  final.pick.switch <- change_door( stay=F, opened.door, first.pick )

  outcome.stay <- determine_winner( final.pick.stay, new.game  )
  outcome.switch <- determine_winner( final.pick.switch, new.game )
  
  strategy <- c("stay","switch")
  outcome <- c(outcome.stay,outcome.switch)
  game.results <- data.frame( strategy, outcome,
                              stringsAsFactors=F )
  return( game.results )
}






#' @title
#'   Play the game many times.
#'
#' @description
#'   `play_n_games()` plays the game `n` times, keeps the results of
#'   every game, and prints the share of wins and losses for each
#'   strategy.
#'
#' @details
#'   One game is not enough to tell which strategy is better, so this
#'   loops through the game many times and stacks all the results. The
#'   more games you run, the closer the win rates get to 0.33 for stay
#'   and 0.67 for switch.
#'
#' @param n a number giving how many games to play. Defaults to 100.
#'
#' @return The function returns a data frame with `2 * n` rows and 2
#'   columns holding the `strategy` and `outcome` of every game. It
#'   also prints a table of win and lose proportions by strategy,
#'   rounded to 2 decimal places.
#'
#' @examples
#'   results <- play_n_games( n=100 )
#'
#' @export
play_n_games <- function( n=100 )
{
  
  library( dplyr )
  results.list <- list()   # collector
  loop.count <- 1

  for( i in 1:n )  # iterator
  {
    game.outcome <- play_game()
    results.list[[ loop.count ]] <- game.outcome 
    loop.count <- loop.count + 1
  }
  
  results.df <- dplyr::bind_rows( results.list )

  table( results.df ) %>% 
  prop.table( margin=1 ) %>%  # row proportions
  round( 2 ) %>% 
  print()
  
  return( results.df )

}

#' player_stats
#'
#' Query the top 100 player's stats (sorted by total points)
#' from the player's summary report endpoint on the NHL.com API.
#'
#' The stats are queried on an aggregated game-by-game basis
#' for a range of dates. If no date is specified the function will
#' return the player's stats for the current season. The stats to be
#' returned are restricted to the regular season.
#'
#' @param a string
#' @param b string
#'
#' @return data.frame
#' @export
#' @examples
#' player_stats(start_date = "2019-10-02", end_date = "2020-02-28")
player_stats <- function(start_date = NULL, end_date = NULL) {
}



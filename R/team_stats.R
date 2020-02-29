#' Team_stats
#'
#' Query the seasons stats for teams specified by start year or start year and end year
#' from the Team Summary Stats API to the the Team's Summary season stats.
#'
#' The stats are queried on an aggregated team by team basis
#' for a range of dates. If no date is specified the function will
#' return the team stats for the current season. 
#' The available seasons range from 1975-1976 to 2018-2019
#' If no year is specified then the year 2019-2020 is default.
#' If an end year is specified then the start year is also to be provided.
#' Year input is to be provided in a 2 year format of 'YYYYYYYY'
#'
#' @param a string
#' @param b string
#'
#' @return data.frame
#' @export
#' @examples
#' team_stats(start_season = "19801981", end_season = "19891990")
team_stats <- function(start_season = NULL, end_season = NULL) {
}

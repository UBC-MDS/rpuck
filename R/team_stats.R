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
#' @param start_season string
#' @param end_season string
#'
#' @return data.frame
#' @export
#' @import httr
#' @import jsonlite
#' @examples
#' team_stats(start_season = "19801981", end_season = "19891990")

team_stats <- function(start_season = NULL, end_season = NULL) {

  # Set the start and end seasons to current season if NULL
  start_season <- if (is.null(start_season)) '20192020' else start_season
  end_season <- if (is.null(end_season)) '20192020' else end_season

  # Check that the argument's are of type character
  if (typeof(start_season) != "character") stop("'start_season' must be of type 'character'")
  if (typeof(end_season) != "character") stop("'end_season' must be of type 'character'")

  # Define the base URL
  url <- "https://api.nhle.com/stats/rest/en/team/summary?"

  # Add in some optional arguments to part of URL string
  options <- glue::glue('cayenneExp=gameTypeId=2%20and%20seasonId<="{end_season}"%20and%20seasonId>={start_season}')

  # Remove all whitespace characters from URL string, and append rest of URL
  url <- gsub("[[:space:]]", "", url) + options

  # Make the URL request
  r <- httr::GET(url)

  # Get the request status code
  status.code <- httr::status_code(r)

  # Check request status code
  if (status.code != 200) stop(paste("Bad request response code -->", status.code))

  # Parse the contents returned as text
  response <- httr::content(r, as = "text", encoding = "UTF-8")

  # Convert the text response to json and then to a data.frame
  df <- data.frame(jsonlite::fromJSON(response, flatten = TRUE)$data)

}


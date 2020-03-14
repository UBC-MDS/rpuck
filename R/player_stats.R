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
#' The function will return the current season's stats if the arguments
#' are blank (i.e. left as None).
#'
#' @param start_date string
#' @param end_date string
#'
#' @return data.frame
#' @export
#' @import httr
#' @import jsonlite
#' @examples
#' player_stats(start_date = "2019-10-02", end_date = "2020-02-28")
player_stats <- function(start_date = NULL, end_date = NULL) {

  # Set the start and end dates to current season if NULL
  start_date <- if (is.null(start_date)) '2019-10-02' else start_date
  end_date <- if (is.null(end_date)) '2020-04-11' else end_date

  # Check that the argument's are of type character
  if (typeof(start_date) != "character") stop("'start_date' must be of type 'character'")
  if (typeof(end_date) != "character") stop("'end_date' must be of type 'character'")

  # Create a variable for the start.date in datetime format
  start.date <- tryCatch( {
      as.POSIXct(start_date, format = "%Y-%m-%d")
    }, error = function(cond) {
      message(glue::glue('Incorrect date format {start_date}, requires YYYY-MM-DD"'))
      message(cond)
      return(NA)
    }, finally = {
      as.POSIXct(start_date, format = "%Y-%m-%d")
    })

  # Create a variable for the end.date in datetime format
  end.date <- tryCatch( {
    as.POSIXct(end_date, format = "%Y-%m-%d")
  }, error = function(cond) {
    message(glue::glue('Incorrect date format {start_date}, requires YYYY-MM-DD"'))
    message(cond)
    return(NA)
  }, finally = {
    as.POSIXct(end_date, format = "%Y-%m-%d")
  })

  # Check that the start and end dates are of the correct format
  if (is.na(start.date) || is.na(end.date)) stop("Arguments must be formatted as 'YYYY-MM-DD'")

  # Check that the start date is earlier than the end date
  if (start.date > end.date) stop("'start_date' must be a date occuring earlier than 'end_date'")

  # Define the base URL
  url <- 'https://api.nhle.com/stats/rest/en/skater/summary?
          isAggregate=true&
          isGame=true&
          sort=%5B%7B%22property%22:%22points%22,%22direction%22:%22DESC%22%7D,
          %7B%22property%22:%22goals%22,%22direction%22:%22DESC%22%7D,
          %7B%22property%22:%22assists%22,%22direction%22:%22DESC%22%7D%5D&
          start=0&
          limit=100&
          factCayenneExp=gamesPlayed%3E=1&'

  # Add in some optional arguments to part of URL string
  options <- glue::glue('cayenneExp=gameDate%3C="{end_date}"%20and%20gameDate%3E="{start_date}"%20and%20gameTypeId=2')

  # Remove all whitespace characters from URL string, and append rest of URL
  url <- gsub("[[:space:]]", "", url) + options

  # Make the URL request
  r <- httr::GET(url)

  # Get the request status code
  status.code <- httr::status_code(r)

  # Check request status code
  if (status.code != 200) stop(paste('Bad request response code -->', status.code))

  # Parse the contestn returned as text
  response <- httr::content(r, as = "text", encoding = "UTF-8")

  # Convert the text response to json and then to a data.frame
  df <- data.frame(jsonlite::fromJSON(response, flatten = TRUE)$data)
}

#' attendance
#'
#' The function will query the NHL attendance number from 1975 to 2019 from the NHL records API. The
#' attendance represents annual attendance numbers for all teams.
#' The user can specify to return either the regular season attendance, playoff attendance
#' numbers, or both. The function will display a chart showing the attendance over the
#' specified time period.
#'
#'
#
#'
#' @param regular boolean
#' @param playoffs boolean
#' @param start_season integer
#' @param end_season integer
#'
#' @return a ggplot object
#'
#' @import dplyr
#' @import ggplot2
#' @import httr
#' @import jsonlite
#' @import tidyr
#'
#' @export
#' @examples
#' attendance(regular=TRUE, playoffs=TRUE, start_season= 2000, end_season=2018)
#'

attendance <- function(regular = TRUE, playoffs = TRUE, start_season = NULL, end_season = NULL) {

  # Specify the URL
  url= 'https://records.nhl.com/site/api/attendance'

  # Make the URL request
  r <- httr::GET(url)
  response <- httr::content(r, as = "text", encoding = "UTF-8")
  # import data
  df <- data.frame(jsonlite::fromJSON(response, flatten = TRUE)$data)
  df <- rename(df, 'playoffs' = 'playoffAttendance', 'regular' = 'regularAttendance')
  df[is.na(df)] <- 0

  # Set the start and end dates to current season if NULL
  start_season <- if (is.null(start_season)) 1975 else start_season
  end_season <- if (is.null(end_season)) 2019 else end_season


  if (!(start_season %in% c(1975:2018)) | !(end_season %in% c(1976:2019))) {
    stop("Please check the season you put, either out of range or non-integer!")
  }

  if (!(is.logical(regular)) | !(is.logical(playoffs))) {
    stop("Regular and playoffs must be logical values!")
  }

  if (start_season >= end_season) {
    stop("Start season should be earlier than end season!")
  }


  start_season <-  strtoi(paste(toString(start_season), toString(start_season), sep =''))
  end_season <- strtoi(paste(toString(end_season), toString(end_season), sep =''))

  df <- filter(df, seasonId >= start_season, seasonId <= end_season)
  df <- mutate(df, season_chr = as.character(seasonId))


  if (regular == TRUE && playoffs == TRUE){
    #plot regular and playoff attendance separately as requested
    data <- gather(df,key='type',value='attendance',playoffs:regular)
    plot <- ggplot(data, aes(x= season_chr, y=attendance))+
      geom_bar(stat ='identity')+
      scale_y_continuous(labels = scales::comma)+
      facet_wrap(~type, scales='free')+
      xlab('Season')+
      ylab('Attendance Number') +
      theme(axis.text.x = element_text(angle = 90, hjust = 1))

  } else if (regular == TRUE){
    # plot regular attendance only if requested
    options(repr.plot.width = 15, repr.plot.height = 10)
    plot <- ggplot(df, aes(x=season_chr, y= regular))+
      geom_bar(stat = "identity")+
      scale_y_continuous(labels = scales::comma)+
      xlab('Season')+
      ylab('Regular Attendance Number') +
      theme(axis.text.x = element_text(angle = 90, hjust = 1))


  } else if (playoffs == TRUE){
    # plot playoff attendance only if requested
    options(repr.plot.width = 15, repr.plot.height = 10)
    plot <- ggplot(df, aes(x=season_chr, y= playoffs))+
      geom_bar(stat = "identity")+
      scale_y_continuous(labels = scales::comma)+
      xlab('Season')+
      ylab('Playoff Attendance Number') +
      theme(axis.text.x = element_text(angle = 90, hjust = 1))

  } else {

    stop("You must select at least one attendance type")

  }

  return (plot)
}


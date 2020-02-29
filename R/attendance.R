#' player_stats
#'
#' This function will make a query to the Attendance API to get
#' the NHL's seasonal and playoff attendance numbers.
#' The function will display the NHL seasonal attendance numbers in a ggplot chart
#'
#' @param regular boolean
#' @param playoffs boolean
#' @param season string
#'
#' @return factor
#' @export
#' @examples
#' rpuck.attendance(regular=True, playoffs=True, season= "2000-11")
#'

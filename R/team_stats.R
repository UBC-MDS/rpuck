#' Make a sorted frequency table for a factor
#'
#' @param x factor
#'
#' @return A tibble
#' @export
#' @examples
#' team_stats(iris$Species)
team_stats <- function(x) {
  forcats::fct_count(x, sort = TRUE)
}



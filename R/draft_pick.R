#' draft_pick
#'
#' Query the result of draft by year summary report endpoint on the NHL.com API.
#'
#' Depending on information provided in the parameters function will return summary 
#' on a person picked in specified draft round, pick and year. If year is not specified 
#' then all of the draft picks for that year will be returned. If no round is specified 
#' the dataframe will include all of the players with chosen pick number from every round.  
#'
#' @param pick_number int in range [1,38]
#' @param round_number int in in range [1,25]
#' @param year str containing a year from 1963 to 2019
#'
#' @return data.frame
#' @export
#' @examples
#' draft_pick(pick_number = 1, round_number = 2, year = '2019')
draft_pick <- function(pick_number = 1, round_number=None, year=None) {
}



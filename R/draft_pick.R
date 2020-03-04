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

library(tidyverse)
library(httr)
library(jsonlite)

draft_pick <- function(pick_number = 1, round_number = NULL, year = NULL){
  test_that('Pick number out of range', {
    expect_true(isin(seq(1,38,1), pick_number))
  })
  
  #TODO input error handling on rest of the parameters
  
  #Setting up API call
  path <- "https://records.nhl.com/site/api/draft"
  request <- GET(url = path)
  response <- content(request, as = "text", encoding = 'UTF-8') 
  df <- fromJSON(response) %>% 
    data.frame()
  df <- select(df,  Player = data.playerName, triCode = data.triCode, Pick_number = data.pickInRound, Round_number = data.roundNumber,
               Year = data.draftYear)
  
  #Selecting based on input data
  if (!is.null(round_number) & !is.null(year)){
    df <- subset(df, Year == year & Round_number == round_number & Pick_number == pick_number)
  }
  else if (!is.null(round_number)){
    df <- subset(df, Round_number == round_number & Pick_number == pick_number)
  }
  else if (!is.null(year)){
    df <- subset(df, Year == year & Pick_number == pick_number)
  }
  else {df <- subset(df, Pick_number == pick_number)}
}



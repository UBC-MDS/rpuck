#' draft_pick
#'
#' Query the result of draft by year summary report endpoint on the NHL.com API.
#'
#' Depending on information provided in the parameters function will return summary 
#' on a person picked in specified draft round, pick and year. If year is not specified 
#' then all of the draft picks for that year will be returned. If no round is specified 
#' the dataframe will include all of the players with chosen pick number from every round.
#' 
#' There are cases when even though user entered valid parameters, output would be empty 
#' if a pick number didn't exist in a specified round, warning would be raised.    
#'
#' @param pick_number int in range [1,38]
#' @param round_number int in in range [1,25]
#' @param year str containing a year from 1963 to 2019
#'
#' @return data.frame
#' @export
#' @examples
#' draft_pick(pick_number = 1, round_number = 2, year = '2019')


draft_pick <- function(pick_number = 1, round_number = NULL, year = NULL){
  
  #Checking proper input 
  test_that('Pick number out of range', {
    expect_true(pick_number %in% seq(1,38,1))
  })
  
  if (!is.null(round_number)){test_that('Round number out of range', {
    expect_true(round_number %in% seq(1,25,1))
  })}
  
  if (!is.null(year)){test_that('Year out of range', {
    expect_true(year %in% seq(1963,2019,1))
  })}
  
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
  
  if (nrow(df) == 0){
    errorCondition()
  }
  #Catching ecxeption cases in output
  if (nrow(df)==0){
    warning('Specified pick number didn`t exist in specified round or year'')
    break
  }
  
  return(df)
}

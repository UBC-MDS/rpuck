
library(testthat)

test_team_stats_errors <- function(){
  test_that("team_stats() function returns errors when expected" , {
    #Check to see that function errors when argument type is wrong
    expect_error(team_stats(start_season = 20192019))
  })
}
test_team_stats_errors()
test_team_stats_returns <- function(){
  test_that("team_stats() function returns proper output" , {
    #Check to see that the function returns a data.frame object with no inputs
    expect_equal(class(team_stats()), "data.frame")
    #Check to see that function returns correct length
    expect_equal(nrow(team_stats(start_season='19531954',end_season='19581959')), 36)
    #Check to see function returns the correct data.frame for the default call (current season)
    expect_equal(mean(team_stats()$seasonId), 20192020)
  })
}
test_team_stats_returns()

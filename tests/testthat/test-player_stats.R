library(testthat)

test_player_stats_errors <- function(){
  test_that("player_stats() function returns errors when expected" , {
    #Check to see that function errors when dates are backwards
    expect_error(player_stats(start_date = '2020-02-28', end_date = '2019-10-02'))
    #Check to see that function errors when argument type is wrong
    expect_error(player_stats(start_date = 2019))
  })
}

test_player_stats_returns <- function(){
  test_that("player_stats() function returns proper output" , {
    #Check to see that the function returns a data.frame object with no inputs
    expect_equal(class(player_stats()), "data.frame")
    #Check to see that function with no inputs returns the correct length
    expect_equal(nrow(player_stats()), 100)
    #Check to see function returns a data.frame with only 1 input
    expect_equal(class(player_stats(start_date = '2019-10-02')), "data.frame")
    #Check to see the function returns a dataframe of length 100 with only 1 input
    expect_equal(nrow(player_stats(start_date = '2019-10-02')), 100)
    #Check to see function returns a data.frame with both inputs of different time periods
    expect_equal(class(player_stats(start_date = '2019-10-02', end_date = '2019-12-05')), "data.frame")
    #Check to see the function returns a dataframe of length 100 with both inputs of different time periods
    expect_equal(nrow(player_stats(start_date = '2019-10-02', end_date = '2019-12-05')), 100)
  })
}

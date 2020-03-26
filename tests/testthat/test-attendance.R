test_attendance <- function(){

  # check if the function returns a ggplot obeject as expected
  # define different scenarios
  a <- attendance(regular = TRUE, playoffs = TRUE, start_season = 1999, end_season = 2007)
  b <- attendance(regular = TRUE, playoffs = FALSE, start_season = 1999, end_season = 2007)
  c <- attendance(regular = FALSE, playoffs = TRUE, start_season = 1999, end_season = 2007)

  test_that("The returned plot should be a ggplot object.", {
    expect_true(ggplot2::is.ggplot(a))
  })

  # check if corresponding error message will be raised when a wrong input is given
  test_that("Error message should be expected if the start season is out of range", {
    expect_error(attendance(regular = TRUE, playoffs = TRUE, start_season = 1950, end_season = 2010),
                 regexp = "Please check the season you put, either out of range or non-integer!")
  })
  test_that("Error message should be expected if the end season is out of range", {
    expect_error(attendance(regular = TRUE, playoffs = TRUE, start_season = 1996, end_season = 2022),
                 regexp = "Please check the season you put, either out of range or non-integer!")
  })
  test_that("Error message should be expected if both regular and playoffs are set to FALSE", {
    expect_error(attendance(regular = FALSE, playoffs = FALSE, start_season = 1996, end_season = 2000),
                 regexp = "You must select at least one attendance type")
  })

  test_that("Error message should be expected if playoffs is set to non_logical value", {
    expect_error(attendance(regular = TRUE, playoffs = 1, start_season = 1996, end_season = 2000),
                 regexp = "Regular and playoffs must be logical values!")
  })

  test_that("Error message should be expected if regular is set to non_logical value", {
    expect_error(attendance(regular = 1, playoffs = TRUE, start_season = 1996, end_season = 2000),
                 regexp = "Regular and playoffs must be logical values!")
  })
  test_that("Error message should be expected if the start season is not as expected", {
    expect_error(attendance(regular = TRUE, playoffs = TRUE, start_season = 'a', end_season = 2000),
                 regexp = "Please check the season you put, either out of range or non-integer!")
  })

  test_that("Error message should be expected if  the end season is not as expected", {
    expect_error(attendance(regular = TRUE, playoffs = TRUE, start_season = 1992, end_season = 'a'),
                 regexp = "Please check the season you put, either out of range or non-integer!")
  })

  test_that("Error message should be expected if end season is earlier than start season", {
    expect_error(attendance(regular = TRUE, playoffs = TRUE, start_season = 1992, end_season = 1989),
                 regexp = "Start season should be earlier than end season!")
  })

}

test_attendance()

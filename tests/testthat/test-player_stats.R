test_that("player_stats() binds factor (or character)", {
  x <- c("a", "b")
  x_fact <- factor(x)
  y <- c("c", "d")
  z <- factor(c("a", "b", "c", "d"))
  
  expect_identical(player_stats(x, y), z)
  expect_identical(player_stats(x_fact, y), z)
})
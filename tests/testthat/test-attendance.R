test_that("attendance() binds factor (or character)", {
  x <- c("a", "b")
  x_fact <- factor(x)
  y <- c("c", "d")
  z <- factor(c("a", "b", "c", "d"))

  expect_identical(attendance(x, y), z)
  expect_identical(attendance(x_fact, y), z)
})

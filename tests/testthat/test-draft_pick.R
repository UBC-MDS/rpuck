library(testthat)

#' Tests the draft_pick function from rpuck package.

test_draft_pick <- function(){
  test_that("draft_pick() function returns proper output and raises errors when expected" , {
    #See if error is raised whith number out of range
    expect_error(draft_pick(round_number = 45))
    #See if error is raised with errorness input
    expect_error(draft_pick(round_number = "nine"))
    #See if error is raised if year out of range
    expect_error(draft_pick(year = 45))
    #See if error is raised whith number out of range
    expect_error(draft_pick(pick_number = 45))
    #See if correct length of data frame is returned
    expect_equal(nrow(draft_pick(1, 2,2010)), 1)
    #See if error is raised if function runs into exeption
    expect_error(draft_pick(1, 8,2010))
    #See if returns correct length with chosen round and pick numbers
    expect_equal(nrow(draft_pick(pick_number = 1, round_number = 7)),50)
    #See if function returns correct length with chosen pick number and year
    expect_true(nrow(draft_pick(pick_number = 1, year = 2010))==7)
    #See if function returns correct length for default parameters
    expect_true(nrow(draft_pick(pick_number = 1))==554)
  })
}
test_draft_pick()
test_that("available locales returns a character vector", {
  expect_vector(trans_available(),
                ptype = character())
})

test_that("all available locales are returned in any order", {
  expect_setequal(trans_available(), c("en_US", "en_UK", "pl"))
})

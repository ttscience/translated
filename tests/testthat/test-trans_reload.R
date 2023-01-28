test_that("reloading results in .TRANS_DICT being populated", {
  trans_reload()
  expect_vector(translated:::.TRANS_DICT,
                ptype = list(),
                size = 2)
  expect_setequal(names(translated:::.TRANS_DICT), c("pl", "en"))
})

test_that("reloading results in .CURRENT_DICT being NULL", {
  trans_reload()
  expect_null(translated:::.CURRENT_DICT)
})

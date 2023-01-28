test_that("passing a locale sets it", {
  trans_locale("pl_PL")
  expect_equal(getOption("translated_locale"), "pl_PL")
})

test_that("not passing anything allows accessing currently set locale", {
  expect_equal(trans_locale(), "pl_PL")
})

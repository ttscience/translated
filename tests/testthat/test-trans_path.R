path <- system.file("examples", package = "translated")

test_that("passing a path sets it", {
  trans_path(path)
  expect_equal(getOption("translated_path"), path)
})

test_that("not passing anything allows accessing currently set path", {
  expect_equal(trans_path(), path)
})

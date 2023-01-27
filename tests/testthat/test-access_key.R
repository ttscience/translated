test_that("simple key access works", {
  expect_equal(
    read_by_key(dict_1, "language"),
    "Canadian English"
  )
})

test_that("compound keys are interpreted properly", {
  expect_equal(
    read_by_key(dict_1, "nouns.animals.dog"),
    "doggie"
  )
})

test_that("returns NULL if key not found", {
  expect_null(read_by_key(dict_1, "unavailable"))
  expect_null(read_by_key(dict_1, "truly.unavailable"))
})

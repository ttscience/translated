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

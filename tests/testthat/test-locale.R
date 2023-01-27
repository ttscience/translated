# interpret_locale ------------------------------------------------------------

# is_valid_locale -------------------------------------------------------------

# null_if_empty ---------------------------------------------------------------
test_that("null_if_empty() returns original string if not empty", {
  expect_equal(null_if_empty("notempty"), "notempty")
})

test_that("null_if_empty() returns NULL if string empty", {
  expect_null(null_if_empty(""))
})

# as.character.trns_locale ----------------------------------------------------

# interpret_locale ------------------------------------------------------------

# is_valid_locale -------------------------------------------------------------
test_that("language only is a valid locale", {
  expect_true(is_valid_locale("eu"))
})

test_that("country code may be added after an underscore", {
  expect_true(is_valid_locale("eu_ES"))
})

test_that("encoding can be included after a dot", {
  expect_true(is_valid_locale("eu_ES.utf8"))
})

test_that("language must be a two-letter code", {
  expect_false(is_valid_locale("eus"))
  expect_false(is_valid_locale("eus_ES"))
})

test_that("country code must be a two-letter code", {
  expect_false(is_valid_locale("eu_France"))
})

test_that("separators cannot be altered", {
  expect_false(is_valid_locale("eu-ES"))
})

test_that("encoding cannot be given without a country code", {
  expect_false(is_valid_locale("eu.utf8"))
})

# null_if_empty ---------------------------------------------------------------
test_that("null_if_empty() returns original string if not empty", {
  expect_equal(null_if_empty("notempty"), "notempty")
})

test_that("null_if_empty() returns NULL if string empty", {
  expect_null(null_if_empty(""))
})

# as.character.trns_locale ----------------------------------------------------

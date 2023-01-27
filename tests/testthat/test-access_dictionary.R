# get_dictionary --------------------------------------------------------------
test_that("current dictionary is always returned", {
  expect_equal(get_dictionary(), translated:::.CURRENT_DICT)
})

# access_dict_by_locale -------------------------------------------------------
test_that("existing locale is accessed straightforwardly", {
  expect_equal(
    access_dict_by_locale("en_US"),
    translated:::.TRANS_DICT[["en"]][["US"]]
  )
})

test_that("invalid locale raises an error", {
  expect_error(access_dict_by_locale("vfr"),
               "must be a valid locale")
})

test_that("language not present raises an error", {
  expect_error(access_dict_by_locale("sk_SK"),
               "Locale 'sk_SK' not available")
})

test_that("language not specified uses default setting", {
  expect_equal(
    access_dict_by_locale("en"),
    translated:::.TRANS_DICT[["en"]][["UK"]]
  )
})

skip("No example yet")

test_that("if default missing, a random country is selected", {
  set.seed(73)
  expect_equal(
    access_dict_by_locale("de"),
    translated:::.TRANS_DICT[["de"]][["AT"]]
  )
})

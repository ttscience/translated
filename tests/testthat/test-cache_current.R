test_that("current locale is saved in .LAST_LOCALE", {
  trans_locale("pl_PL")
  cache_dictionary()
  expect_equal(translated:::.LAST_LOCALE, "pl_PL")
})

test_that("current locale is set", {
  trans_reload()
  cache_dictionary()
  expect_vector(translated:::.CURRENT_DICT,
                ptype = list(),
                size = 2)
  expect_named(translated:::.CURRENT_DICT, c("config", "translation"))
  expect_equal(
    translated:::.CURRENT_DICT[["translation"]][["title"]],
    "Generator liczb predefiniowanych"
  )
})

test_that("missing entries are properly inherited", {
  trans_locale("en_UK")
  cache_dictionary()
  expect_equal(
    translated:::.CURRENT_DICT[["translation"]][["title"]],
    "Predefined number generator"
  )
})

test_that("existing entries are not overwritten by inherited localization", {
  expect_equal(
    translated:::.CURRENT_DICT[["translation"]][["nouns"]][["behavior"]],
    "behaviour"
  )
})

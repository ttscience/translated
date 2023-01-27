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

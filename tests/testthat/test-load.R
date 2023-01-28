# load_translations -----------------------------------------------------------

# standardize_locales ---------------------------------------------------------
std_json_data <- standardize_locales(json_data)

test_that("each locale is a `trns_locale` object after standardization", {
  for (json in std_json_data) {
    locale <- json[["config"]][["locale"]]
    expect_s3_class(locale, "trns_locale")
    expect_named(locale, c("language", "country", "encoding"))
    # No locale in the examples have encoding
    expect_null(locale[["encoding"]])
  }
})

test_that("translation data is left unchanged", {
  for (i in seq_along(std_json_data)) {
    expect_equal(
      std_json_data[[i]][["translation"]],
      json_data[[i]][["translation"]]
    )
  }
})

test_that("NULL country is replaced with '_unknown'", {
  json_pl <- Find(function(json) {
    json[["config"]][["locale"]][["language"]] == "pl"
  }, std_json_data)

  expect_equal(json_pl[["config"]][["locale"]][["country"]], "_unknown")
})

# find_default_locales --------------------------------------------------------

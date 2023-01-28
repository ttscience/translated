trans_locale("en_US")

test_that("simple access works properly", {
  expect_equal(trans("title"), "Predefined number generator")
})

test_that("named parameters fill gaps", {
  expect_equal(trans("btn_insert", number = 4), "Insert 4")
  expect_equal(trans("btn_insert", number = "coin"), "Insert coin")
})

test_that("unused named parameters are ignored", {
  expect_equal(trans("title", ignored = "yes"), "Predefined number generator")
  expect_equal(trans("btn_insert", number = 3, letter = "a"), "Insert 3")
})

test_that("`.n` can be used to translate count-dependent phrases", {
  expect_equal(trans("cat", .n = 0), "no cats")
  expect_equal(trans("cat", .n = 1), "1 cat")
  expect_equal(trans("cat", .n = 4), "4 cats")
})

test_that("group entry access with dots is possible", {
  expect_equal(trans("nouns.behavior"), "behavior")
  expect_equal(trans("nouns.cat", .n = 3), "3 cats")
})

test_that("nested translations function properly", {
  expect_equal(
    trans("result", n_files = 4, n_dirs = 1),
    "Scanned 4 files in 1 directory."
  )
})

test_that("if key is missing in localization, key is returned with a warning", {
  expect_warning(
    ret <- trans("missing"),
    "'missing' key is missing translation for locale 'en_US'"
  )
  expect_equal(ret, "missing")
})

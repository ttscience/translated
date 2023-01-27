# preprocess_plural -----------------------------------------------------------
plural_1 <- "n == 1 ~ 2, n %% 4 == 3 ~ 3, TRUE ~ 1"
plural_post <- list(
  c("n==1", "2"),
  c("n%%4==3", "3"),
  c("TRUE", "1")
)

test_that("cases are split by a comma", {
  expect_vector(preprocess_plural(plural_1),
                ptype = list(),
                size = 3)
})

test_that("each case has a condition and a result split by a tilde", {
  for (case in preprocess_plural(plural_1)) {
    expect_vector(case,
                  ptype = character(),
                  size = 2)
  }
})

test_that("result is split on commas and tildes", {
  expect_equal(preprocess_plural(plural_1), plural_post)
})

test_that("plural is preprocessed even if only one case", {
  ret <- preprocess_plural("n >= 0 ~ 1")
  expect_vector(ret,
                ptype = list(),
                size = 1)
  expect_vector(ret[[1]],
                ptype = character(),
                size = 2)
})

test_that("malformed plural cases are detected", {
  expect_error(preprocess_plural("n == 1 ~ 2, n %% 4 == 3 ~ 3, TRUE ~"),
               "Malformed definition")
  expect_error(preprocess_plural("n == 1 ~ 2, n %% 4 == 3 ~ 3; TRUE ~ 1"),
               "Malformed definition")
  expect_error(preprocess_plural("n == 1 ~ 2, n %% 4 == 3"),
               "Malformed definition")
})

# choose_plural_case ----------------------------------------------------------
test_that("plural is evaluated using `n` variable", {
  expect_equal(choose_plural_case(dict_1, n = 22), 1)
})

test_that("first matching case is chosen", {
  expect_equal(choose_plural_case(dict_1, n = 1), 2)
  expect_equal(choose_plural_case(dict_1, n = 11), 3)
})

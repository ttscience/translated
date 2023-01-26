#' @importFrom glue glue
interpret_locale <- function(locale) {
  if (!is_valid_locale(locale)) {
    stop(glue("'{locale}' must be a valid locale"), call. = FALSE)
  }

  regex <- "(.{2})(?:_(.{2})(?:\\.(.*))?)?"
  ret <- regmatches(locale, regexec(regex, locale, perl = TRUE))
  # Locale should be length 1
  structure(
    list(
      language = ret[[1]][2],
      country = null_if_empty(ret[[1]][3]),
      encoding = null_if_empty(ret[[1]][4])
    ),
    class = "trns_locale"
  )
}

is_valid_locale <- function(locale) {
  regex <- "^\\w{2}(_\\w{2}(\\..+)?)?$"
  grepl(regex, locale, perl = TRUE)
}

null_if_empty <- function(text) {
  if (text == "") NULL else text
}

#' @importFrom glue glue
#' @export
as.character.trns_locale <- function(x, ...) {
  if (is.null(x[["country"]])) {
    glue("{x[['language']]}")
  } else if (is.null(x[["encoding"]])) {
    glue("{x[['language']]}_{x[['country']]}")
  } else {
    glue("{x[['language']]}_{x[['country']]}.{x[['encoding']]}")
  }
}

#' @export
print.trns_locale <- function(x, ...) {
  print(as.character(x), ...)
}

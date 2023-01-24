#' @importFrom glue glue
#' @export
trans <- Vectorize(function(.key, ..., .n = NULL) {
  .ret <- read_by_key(get_dictionary(), .key)

  # If key not found in translation, warn user and return untranslated key
  if (is.null(.ret)) {
    warning(
      glue("'{.key}' key is missing translation for current locale."),
      call. = FALSE
    )
    return(.key)
  }

  # Handle plural values
  if (!is.null(.n)) {
    .index <- choose_plural_case(get_dictionary(), .n)
    .ret <- .ret[[.index]]
  }

  # Substitute variables within translation
  glue(.ret, ...)
}, vectorize.args = ".key", SIMPLIFY = TRUE, USE.NAMES = FALSE)

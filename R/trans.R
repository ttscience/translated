#' @importFrom glue glue
#' @export
trans <- Vectorize(function(.key, ..., .n = NULL) {
  dict <- get_dictionary()
  .ret <- read_by_key(dict, .key)

  # If key not found in translation, warn user and return untranslated key
  if (is.null(.ret)) {
    dict_locale <- dict[["config"]][["locale"]]
    warning(
      glue("'{.key}' key is missing translation for locale '{dict_locale}'."),
      call. = FALSE
    )
    return(.key)
  }

  # Handle plural values
  if (!is.null(.n)) {
    .index <- choose_plural_case(dict, .n)
    .ret <- .ret[[.index]]
  }

  # Substitute variables within translation
  glue(.ret, ...)
}, vectorize.args = ".key", SIMPLIFY = TRUE, USE.NAMES = FALSE)

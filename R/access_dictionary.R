#' @importFrom glue glue
get_dictionary <- function() {
  # Lazy read translation JSONs
  if (is.null(.TRANS_DICT)) {
    trans_reload()
  }
  if (is.null(.CURRENT_DICT) ||
      getOption("translated_locale") != .LAST_LOCALE) {
    cache_dictionary()
  }
  .CURRENT_DICT
}

access_dict_by_locale <- function(locale) {
  locale <- interpret_locale(locale)
  language <- locale[["language"]]
  country <- locale[["country"]]

  if (!language %in% names(.TRANS_DICT)) {
    stop(glue("Locale '{locale}' not available."), call. = FALSE)
  }
  country_map <- .TRANS_DICT[[language]]

  # If unable to choose dictionary for the (un-)specified country
  if (is.null(country) || !country %in% names(country_map)) {
    country <- attr(country_map, "default", exact = TRUE)
    # If no default, choose random country
    if (is.null(country)) {
      country <- sample(names(country_map), 1)
    }
  }
  country_map[[country]]
}

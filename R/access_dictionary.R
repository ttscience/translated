#' @importFrom glue glue
get_dictionary <- function() {
  # Lazy read translation JSONs
  if (is.null(.TRANS_DICT)) {
    trans_reload()
  }

  locale <- interpret_locale(getOption("translated_locale"))
  language <- locale[["language"]]
  country <- locale[["country"]]

  if (!language %in% names(.TRANS_DICT)) {
    stop(glue("Locale '{locale}' not available."), call. = FALSE)
  }
  country_map <- .TRANS_DICT[[language]]

  if (is.null(country) || !country %in% names(country_map)) {
    if ("_default" %in% names(country_map)) {
      country <- "_default"
    } else {
      # If no default, choose random country
      country <- sample(names(country_map), 1)
    }
  }
  country_map[[country]]
}

read_by_key <- function(dict, key) {
  # TODO: should the user be allowed to use `.` as a compound path to the key?
  #  could be useful for organizing translations in multiple files/domains
  dict[["translation"]][[key]]
}

# TODO: perhaps add `.CURRENT_DICT` so that extraction can be skipped if locale
#  hasn't changed (keep tracking of last locale then?)
# TODO: what about fallbacks?

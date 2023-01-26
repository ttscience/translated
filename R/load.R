.TRANS_DICT <- NULL

#' @importFrom jsonlite read_json
#' @importFrom stats setNames
#' @importFrom utils modifyList
load_translations <- function() {
  if (is.null(getOption("translated_path"))) {
    stop("Must define translation path first using `trans_path()`", call. = FALSE)
  }

  # Read files
  json_data <- lapply(
    list.files(
      getOption("translated_path"),
      pattern = getOption("translated_pattern"),
      full.names = TRUE
    ),
    read_json
  )

  json_data <- standardize_locales(json_data)
  default_locales <- find_default_locales(json_data)

  # Build translation map out of read content
  ret <- Reduce(function(ret, json) {
    lang <- json[["config"]][["locale"]][["language"]]
    country <- json[["config"]][["locale"]][["country"]]
    # Actual data is stored inside two levels of lists
    # The first level is language, the second - country code
    data_to_insert <- setNames(list(setNames(list(json), country)), lang)
    modifyList(ret, data_to_insert)
  }, json_data, init = list())

  # Add defaults to the result
  Reduce(function(dict, default) {
    attr(dict[[default[["lang"]]]], "default") <- default[["country"]]
    dict
  }, default_locales, init = ret)
}

standardize_locales <- function(data) {
  lapply(data, function(json) {
    json[["config"]][["locale"]] <- interpret_locale(json[["config"]][["locale"]])
    if (is.null(json[["config"]][["locale"]][["country"]])) {
      json[["config"]][["locale"]][["country"]] <- "_unknown"
    }
    json
  })
}

#' @importFrom glue glue
find_default_locales <- function(data) {
  Reduce(function(defaults, json) {
    lang <- json[["config"]][["locale"]][["language"]]
    country <- json[["config"]][["locale"]][["country"]]

    if (!is.null(json[["config"]][["default"]]) &&
        json[["config"]][["default"]]) {
      priority <- 20
    } else if (country == "_unknown") {
      # Locales without country code should be treated as default, but less
      # important than
      priority <- 10
    } else {
      # No change to be made
      return(defaults)
    }

    if (!lang %in% names(defaults) ||
        priority > defaults[[lang]][["priority"]]) {
      defaults[[lang]] <- list(
        country = country, lang = lang, priority = priority
      )
    } else if (priority == defaults[[lang]][["priority"]]) {
      # Do not overwrite defaults if priority equal...
      if (country != defaults[[lang]][["country"]]) {
        # ...but warn the user if there's a conflict
        warning(glue(
          "Can't decide default for '{lang}' language - ",
          "'{country}' or '{defaults[[lang]][['country']]}'?"
        ), call. = FALSE)
      }
    }

    defaults
  }, data, init = list())
}

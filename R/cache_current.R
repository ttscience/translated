.CURRENT_DICT <- NULL
.LAST_LOCALE <- NULL

#' @importFrom utils modifyList
cache_dictionary <- function() {
  assignInMyNamespace(".LAST_LOCALE", getOption("translated_locale"))

  ret <- access_dict_by_locale(.LAST_LOCALE)
  inherit <- ret[["config"]][["inherit"]]
  while (!is.null(inherit)) {
    add <- access_dict_by_locale(inherit)
    inherit <- add[["config"]][["inherit"]]
    ret <- modifyList(add, ret)
  }
  ret[["config"]][["plural"]] <- preprocess_plural(ret[["config"]][["plural"]])

  assignInMyNamespace(".CURRENT_DICT", ret)
}

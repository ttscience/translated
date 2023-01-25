.TRANS_DICT <- NULL

#' @importFrom jsonlite read_json
#' @importFrom stats setNames
#' @importFrom utils modifyList
load_translations <- function() {
  # Read files
  json_data <- lapply(
    list.files(
      getOption("translated_path"),
      pattern = getOption("translated_pattern"),
      full.names = TRUE
    ),
    read_json
  )

  # Build translation map out of read content
  Reduce(function(ret, json) {
    locale <- interpret_locale(json[["config"]][["locale"]])
    # Actual data is stored inside two levels of lists
    # The first level is language, the second - country code
    data_to_insert <- setNames(
      list(setNames(
        list(json),
        # Country might be missing for simple locales
        if (is.null(locale[["country"]])) "_default" else locale[["country"]]
      )),
      locale[["language"]]
    )
    modifyList(ret, data_to_insert)
  }, json_data, init = list())
}

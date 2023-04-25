#' Display available locales
#'
#' @description This function displays available locales
#'
#' @return Returns available locales in df
#'
#' @examples
#' path <- system.file("examples", package = "translated")
#' trans_path(path)
#'
#' # Display available locales
#' trans_available()
#'
#' @importFrom jsonlite read_json
#' @export
trans_available <- function() {
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
    jsonlite::read_json
  )

  # find the available locales from the nested list
  vapply(json_data, function(x) {
    x[["config"]][["locale"]]
  }, character(1))
}

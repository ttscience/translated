#' @export
trans_path <- function(path) {
  if (missing(locale)) {
    getOption("translated_path")
  } else {
    options(translated_path = path)
  }
}

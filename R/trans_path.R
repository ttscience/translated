#' @export
trans_path <- function(path) {
  if (missing(path)) {
    getOption("translated_path")
  } else {
    options(translated_path = path)
  }
}

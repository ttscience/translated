#' @importFrom utils assignInMyNamespace
#' @export
trans_reload <- function() {
  assignInMyNamespace(".TRANS_DICT", load_translations())
}

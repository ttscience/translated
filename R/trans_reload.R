#' Force translation reload
#'
#' @description This function forces the translations to be loaded from JSON
#' files again.
#'
#' @examples
#' trans_path(system.file("examples", package = "translated"))
#' trans_reload()
#'
#' @return No return value, called for its side effect.
#'
#' @importFrom utils assignInMyNamespace
#' @export
trans_reload <- function() {
  assignInMyNamespace(".TRANS_DICT", load_translations())
  assignInMyNamespace(".CURRENT_DICT", NULL)
}

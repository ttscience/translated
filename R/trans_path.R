#' Access translation path
#'
#' @description This function allows setting translation path and accessing the
#' currently set one.
#'
#' @param path `character(1)`\cr
#'  Path to set, should be a folder containing JSON files (possibly in
#'  subdirectories).
#'
#' @return If `path` was not passed, currently set path, else nothing.
#'
#' @examples
#' # Set path to example translations shipped with this package
#' trans_path(system.file("examples", package = "translated"))
#'
#' # Check the current path
#' trans_path()
#'
#' @export
trans_path <- function(path) {
  if (missing(path)) {
    getOption("translated_path")
  } else {
    options(translated_path = path)
  }
}

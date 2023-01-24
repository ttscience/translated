#' @importFrom dplyr case_when
choose_plural_case <- function(dict, .n) {
  plural <- dict[["config"]][["plural"]]
  # TODO: maybe devise a custom language for describing plurality rules?
  eval(str2lang(plural))
}

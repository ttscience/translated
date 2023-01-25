#' @importFrom dplyr case_when
choose_plural_case <- function(dict, .n) {
  plural <- dict[["config"]][["plural"]]
  eval(str2lang(plural))
}

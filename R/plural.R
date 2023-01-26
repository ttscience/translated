choose_plural_case <- function(dict, n) {
  definition <- dict[["config"]][["plural"]]
  cases <- strsplit(definition, ",", fixed = TRUE)[[1]]
  conditions <- strsplit(cases, "~", fixed = TRUE)
  ret <- Find(function(cond) {
    eval(str2lang(cond[1]))
  }, conditions)
  eval(str2lang(ret[2]))
}

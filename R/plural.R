choose_plural_case <- function(dict, n) {
  conditions <- dict[["config"]][["plural"]]
  ret <- Find(function(cond) {
    eval(str2lang(cond[1]))
  }, conditions)
  eval(str2lang(ret[2]))
}

preprocess_plural <- function(definition) {
  cases <- strsplit(definition, ",", fixed = TRUE)[[1]]
  strsplit(cases, "~", fixed = TRUE)
}

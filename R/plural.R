choose_plural_case <- function(dict, n) {
  conditions <- dict[["config"]][["plural"]]
  ret <- Find(function(cond) {
    eval(str2lang(cond[1]))
  }, conditions)
  eval(str2lang(ret[2]))
}

#' @importFrom glue glue
preprocess_plural <- function(definition) {
  # Remove whitespace - it's effectively ignored and it makes it easier to check
  #  the definition structure
  definition <- gsub("\\s", "", definition)
  if (!grepl("^[^~,]+~[^~,]+(,[^~,]+~[^~,]+)*$", definition)) {
    stop(glue("Malformed definition: '{definition}'"))
  }

  cases <- strsplit(definition, ",", fixed = TRUE)[[1]]
  strsplit(cases, "~", fixed = TRUE)
}

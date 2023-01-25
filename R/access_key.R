read_by_key <- function(dict, key) {
  key <- strsplit(key, ".", fixed = TRUE)[[1]]
  Reduce(`[[`, key, init = dict[["translation"]])
}

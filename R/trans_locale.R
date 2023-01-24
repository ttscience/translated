#' @export
trans_locale <- function(locale) {
  if (missing(locale)) {
    getOption("translated_locale")
  } else {
    options(translated_locale = locale)
  }
}

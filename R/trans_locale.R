#' Access translation locale
#'
#' @description This function allows setting translation locale and accessing
#' the currently set one.
#'
#' @param locale `character(1)`\cr
#'  Locale to set, must be of form `"lang_country.encoding"` (or simplified
#'  ones, i.e. `"lang_country"` and `"lang"`). `lang` and `country` must be
#'  two-letter codes, preferably in agreement with the latest ISO norm.
#'
#' @return If `locale` was not passed, currently set locale, else nothing.
#'
#' @examples
#' trans_path(system.file("examples", package = "translated"))
#'
#' # Check your default locale
#' trans_locale()
#'
#' # Switch the translation to Polish language
#' trans_locale("pl_PL")
#' trans("title")
#'
#' @export
trans_locale <- function(locale) {
  if (missing(locale)) {
    getOption("translated_locale")
  } else {
    options(translated_locale = locale)
  }
}

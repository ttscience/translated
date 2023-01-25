#' Translate strings
#'
#' @description This function finds a translation for given keys in translation
#' JSON files. If none found, a bare key is returned and a warning raised.
#' Translation language is controlled by \code{\link{trans_locale}()} function.
#'
#' Translation strings may contain `{var}` chunks. These are replaced in the
#' final string by respective strings passed to `...`.
#'
#' If a translation depends on a count, a `.n` parameter allows the user to
#' select an appropriate translation form. Count interpretation is defined
#' within translation JSONs for each language separately under `$.config.plural`
#' path. Integer returned by this interpretation function is used as index for
#' extracting the correct translation from an array.
#'
#' Thanks to the implementation strategy, it is possible to create recursive
#' translations (i.e. translations whose smaller chunks are translations
#' themselves). This makes it possible to translate statements like
#' "Found n file(s) in m directory/ies" by translating "files" and "directories"
#' chunks first. In this case an appropriate translation entry would look like:
#' "Found {trans("file", .n = n_files)} in {trans("directory", .n = n_dirs)}".
#' Braces evaluate the content inside as R code.
#'
#' @param .key `character()`\cr
#'  Keys to the translation map (accepts vectors of strings). Keys should not
#'  contain dots, unless it's a compound key (where dots separate parts of
#'  path to the key, e.g. `"submit_form.buttons.reset"`).
#' @param ... `character(1)`\cr
#'  Named strings to substitute into translation; they replace substrings of the
#'  form `"{var}"` (`var` being a name of a string). Avoid names starting with
#'  dots to avoid incompatibility issues with future versions of this package.
#' @param .n `integer(1)`\cr
#'  Count for translating value-dependent messages, e.g. "n file(s)".
#'
#' @return A string vector of the same length as `.key`, each element being a
#' translated string.
#'
#' @examples
#' trans_path(system.file("examples", package = "translated"))
#'
#' trans("title")
#' trans("btn_insert", number = "five")
#' # Non-character values are coerced to strings
#' trans("btn_insert", number = 5)
#'
#' # Missing entries raise a warning and return the key
#' trans("missing_entry")
#'
#' @importFrom glue glue
#' @export
trans <- Vectorize(function(.key, ..., .n = NULL) {
  dict <- get_dictionary()
  .ret <- read_by_key(dict, .key)

  # If key not found in translation, warn user and return untranslated key
  if (is.null(.ret)) {
    dict_locale <- dict[["config"]][["locale"]]
    warning(
      glue("'{.key}' key is missing translation for locale '{dict_locale}'."),
      call. = FALSE
    )
    return(.key)
  }

  # Handle plural values
  if (!is.null(.n)) {
    .index <- choose_plural_case(dict, .n)
    .ret <- .ret[[.index]]
  }

  # Substitute variables within translation
  glue(.ret, ...)
}, vectorize.args = ".key", SIMPLIFY = TRUE, USE.NAMES = FALSE)

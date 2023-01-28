.onLoad <- function(libname, pkgname) { # nocov start
  prev_options <- options()

  new_options <- list(
    translated_path = NULL,
    translated_pattern = ".*\\.json",
    translated_locale = "en_US"
  )

  unset_inds <- !(names(new_options) %in% names(prev_options))
  if (any(unset_inds)) {
    options(new_options[unset_inds])
  }

  invisible()
} # nocov end

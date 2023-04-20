#' Display available locales
#' 
#' @description This function displays available locales 
#' 
#' @return Returns available locales in df
#'
#' @examples
#' library(translated)
#' path <- system.file("examples", package = "translated")
#' trans_path(path)
#'
#' # Display available locales
#' trans_available_locales()
#' 
#' @importFrom jsonlite read_json
#' @export
trans_available_locales <- function() {
  if (is.null(getOption("translated_path"))) {
    stop("Must define translation path first using `trans_path()`", call. = FALSE)
  }
  
  # Read files
  json_data <- lapply(
    list.files(
      getOption("translated_path"),
      pattern = getOption("translated_pattern"),
      full.names = TRUE
    ),
    jsonlite::read_json
  )
  
  # find the available locales from the nested list  
  tmp_list <- lapply(json_data, function(x) x[["config"]][["locale"]])
  
  # create neater available locales display
  available_list <- as.data.frame(do.call(rbind, lapply(tmp_list, as.data.frame)))
  colnames(available_list) <- "Available Locales"
  
  return(available_list)
}  

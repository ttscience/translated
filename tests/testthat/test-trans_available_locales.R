test_that("test available locales display", {
  
  # create expected reference value
  path <- system.file("examples", package = "translated")
  trans_path(path)
  
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
  expected_available_list <- as.data.frame(do.call(rbind, lapply(tmp_list, as.data.frame)))
  colnames(expected_available_list) <- "Available Locales"
  
  observed_available_list <- translated::trans_available_locales()
  
  expect_equal(expected_available_list, observed_available_list)
})


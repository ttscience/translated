json_data <- lapply(
  list.files(trans_path(), pattern = ".*\\.json", full.names = TRUE),
  jsonlite::read_json
)

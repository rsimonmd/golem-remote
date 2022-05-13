#' pool
#'
#' @description A fct function
#'
#' @importFrom pool dbPool
#'
#' @noRd
con <-
  pool::dbPool(
  RSQLite::SQLite(),
  dbname = "inst/dev.sqlite"
)

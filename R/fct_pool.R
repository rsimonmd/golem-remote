#' pool
#'
#' @description A fct function
#'
#' @importFrom pool dbPool
#' @importFrom RSQLite SQLite
#'
#' @noRd
con <-
  pool::dbPool(
  RSQLite::SQLite(),
  dbname = "inst/dev.sqlite"
)

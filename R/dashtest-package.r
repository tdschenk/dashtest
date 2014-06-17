#' dashtest.
#'
#' @name dashtest
#' @docType package
NULL

#' @export
plottest <- function(df, ...) {
  plot(df$lat ~ df$lon)
}
#' dashtest.
#'
#' @name dashtest
#' @docType package
NULL

#' @export
mapplot <- function(data, params, ...) {
  data$lat <- data$lat - 70
  map <- get_googlemap(center = c(lon = 50, lat = 30), zoom = 6)
  ggmap(map) + geom_point(aes(x = lon, y = lat, color = pt), 
                          data = data)
}

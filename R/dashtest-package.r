#' dashtest.
#'
#' @name dashtest
#' @docType package
#' @import ggmaps
NULL

#' @export
mapplot <- function(data, params, ...) {
  data$lat <- data$lat - 70
  meanlat <- mean(data$lat)
  meanlon <- mean(data$lon)
  map <- get_googlemap(center = c(lon = meanlon, lat = meanlat), zoom = 6)
  ggmap(map) + geom_point(aes(x = lon, y = lat, color = pt), 
                          data = data)
}

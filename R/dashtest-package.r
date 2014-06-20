#' dashtest.
#'
#' @name dashtest
#' @docType package
#' @import ggmap
#' @import ggvis
NULL

## Plot lat/lon points on a map
#' @export
mapplot <- function(data, params, ...) {
  data$lat <- data$lat - 70
  meanlat <- mean(data$lat)
  meanlon <- mean(data$lon)
  map <- get_googlemap(center = c(lon = meanlon, lat = meanlat), zoom = 6)
  ggmap(map) + geom_point(aes(x = lon, y = lat, color = pt), 
                          data = data)
}

## A simple test using ggvis
#' @export
vistest <- function(data, params, ...) {
  data %>%
    ggvis(~lat, ~lon,
          size := input_slider(1, 100, label = "size"),
          opacity := input_slider(0, 1, label = "opacity"),
          fill = ~pt
    ) %>%
  layer_points()
}
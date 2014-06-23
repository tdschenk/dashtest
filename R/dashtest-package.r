#' dashtest.
#'
#' @name dashtest
#' @docType package
#' @import ggmap ggvis
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
  ggvis_plot <- data %>%
    ggvis(~lat, ~lon,
          fill = ~pt
    ) %>%
    layer_points()
  unbox(paste0(capture.output(show_spec(ggvis_plot)), collapse = ""))
}

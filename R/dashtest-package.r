#' dashtest.
#'
#' @name dashtest
#' @docType package
#' @import ggmap ggvis

## Plot lat/lon points on a map
#' @export
mapplot <- function(data, params, ...) {
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
}

## Return data as a dataframe
#' @export
getframe <- function(data, params, ...) {
  data
}

## Testing
#' @export
testfun <- function(data, params, ...) {
  plot(1:10)
}

## Bar chart of records per day
#' @export
records.per.day <- function(data, params, ...) {
  data[,4]<- as.POSIXct(substr(data[,3],0,10),format="%Y-%m-%d")
  data$count <- as.character( round(data[,4] , "day" ) )
  a <- aggregate( df , by = list(data$count) , length )
  c <- ggplot(df, aes(factor(day))) + 
    geom_bar()
  c
}
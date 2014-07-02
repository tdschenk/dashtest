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

## Bar chart of records per day
#' @export
records.per.day <- function(data, params, ...) {
  data[,4]<- as.POSIXct(substr(data[,3],0,10),format="%Y-%m-%d")
  data$count <- as.character( round(data[,4] , "day" ) )
  a <- aggregate( data , by = list(data$count) , length )
  a %>%
    ggvis(x = ~Group.1, y = ~count, fill := "tan") %>%
    layer_bars() %>%
    add_axis("x", title = "Day") %>%
    add_axis("y", title = "Number of Records")
}

##
#' @export
records.per.hour <- function(data, params, ...) {
  data[,4]<- substr(data[,3],12,13)
  dt <- as.data.frame(table(data$time))
  dt %>%
    ggvis(x = ~Var1, y = ~Freq, fill := "tan") %>%
    layer_bars() %>%
    add_axis("x", title = "Hour") %>%
    add_axis("y", title = "Number of Records")
}

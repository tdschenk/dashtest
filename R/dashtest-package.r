#' dashtest.
#'
#' @name dashtest
#' @docType package
#' @import ggmap ggvis leafletR

## Plot lat/lon points on a map
#' @export
mapplot <- function(data, params, ...) {
  meanlat <- mean(data$lat)
  meanlon <- mean(data$lon)
  map <- get_googlemap(center = c(lon = meanlon, lat = meanlat), zoom = 6)
  ggmap(map) + geom_point(aes(x = lon, y = lat, color = pt), 
                          data = data)
}

#' @export
chr_plot <- function(data, params, ...) {
  data %>%
    ggvis(~measure_1_numerator, ~measure_2_numerator) %>%
    layer_points()
}


## A simple scatterplot using ggvis
#' @export
scattervis <- function(data, params, ...) {
  ggvis_plot <- data %>%
    ggvis(~lat, ~lon,
          fill = ~pt
    ) %>%
    layer_points() %>%
    add_axis("x", title = "Latitude") %>%
    add_axis("y", title = "Longitude")
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
    add_axis("x", title = "Day",
             properties = axis_props(labels = list(angle = 45, align = "left"))) %>%
    add_axis("y", title = "Number of Records")
}

## Bar chart of records per hour
#' @export
records.per.hour <- function(data, params, ...) {
  data[,4]<- substr(data[,3],12,13)
  dt <- as.data.frame(table(data[,4]))
  dt %>%
    ggvis(x = ~Var1, y = ~Freq, fill := "tan") %>%
    layer_bars() %>%
    add_axis("x", title = "Hour") %>%
    add_axis("y", title = "Number of Records")
}

## A graph of number of steps per day from fitbit 
#' @export
steps.per.day <- function(data, params, ...) {
  data %>%
    ggvis(x = ~dateTime, y = ~value) %>%
    layer_lines() %>%
    add_axis("x", title = "Day", properties = axis_props(labels = list(angle = 45, align = "left"))) %>%
    add_axis("y", title = "Steps")
}

## Map plot using leaflet
#' @export
leaflet.plot <- function(data, params, ...) {
  path <- toGeoJSON(data, lat.lon=c(10,5), dest=tempdir())
  map <- leaflet(path, dest=tempdir())
  browseURL(map)
}

## (Gruve) Daily calorie expenditure vs daily calorie goal
#' @export
calorie.goals <- function(data, params, ...) {
  data$day <- substr(data$dayTimestamp,0,10)
  data <- data[order(data$day),]
  data %>%
    ggvis(x = ~day, y = ~dayTotalCalories) %>%
    layer_paths(stroke := "darkorange", fill = "Goal", fillOpacity = 0, strokeWidth := 3) %>%
    layer_paths(x = ~day, y = ~dayCalorieGoal, stroke := "royalblue",
                fill = "Actual", fillOpacity = 0, strokeWidth := 3) %>%
    add_axis("x", title = "",
             properties = axis_props(labels = list(angle = 45, align = "left"))) %>%
    add_axis("y", title = "Calories")
}

## (Fitbit) Daily step counts
#' @export
fitbit.steps <- function(data, params, ...) {
  data$timestamp <- as.Date(data$timestamp)
  data %>%
    ggvis(x = ~timestamp, y = ~value) %>%
    layer_paths(stroke := "navy", fillOpacity = 0, strokeWidth := 3) %>%
    add_axis("x", title = "", 
             properties = axis_props(labels = list(angle = 45, align = "left"))) %>%
    add_axis("y", title_offset = 50, title = "Steps" )%>% 
    scale_datetime("x", nice = "week")
}

## (Fitbit) Calendar heatmap
#' @export
fitbit.heatmap <- function(data, params, ...) {
  data <- transform(data,
                    week = as.character(as.POSIXlt(timestamp)$yday %/% 7 + 1),
                    wday = as.numeric(as.POSIXlt(timestamp)$wday),
                    year = as.POSIXlt(timestamp)$year + 1900)
  data$day <- weekdays(as.Date(data$timestamp))
  
  ## Attempt to translate to ggvis
  data %>%
    ggvis(~week, ~day, fill = ~value) %>%
    layer_rects(height = band(), width = band()) %>%
    scale_nominal("x", padding = 0, points = FALSE) %>%
    scale_nominal("y", padding = 0, points = FALSE) %>%
    add_axis("x", title = "Week") %>%
    add_axis("y", title = "") %>%
    add_legend(title = "Steps Taken")
}

#' @export
multidata_test <- function(data, params, ...) {
  steps <- nrow(data$steps)
  tags <- nrow(data$event_tags)
  ptext <- paste0("steps: ", steps, " tags: ", tags)
  data2 <- data.frame(x = 1, y = 1)
  ret <- data2 %>% ggvis(~x, ~y) %>% 
    layer_text(text:=ptext,
               dx := 50, fontWeight := "bold", fontSize := 20) %>%  
    hide_axis("x") %>% 
    hide_axis("y")
  ret
}
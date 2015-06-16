## Liitah Testing (Location->Name)
## data <- read.csv("~/Practice/Liitah/js-venues.csv")
#' @export
liitah_venue_map <- function(data, params, ...) {
  data <- data$venue
  # Extract gps data from JSON string and merge into dataframe
  gps <- data.frame(lat = numeric(), lon = numeric(), radius = numeric())
  for (i in 1:nrow(data)) {
    gps_record <- fromJSON(paste0("[ ", toString(data$trig_info[i]), " ]"))
    gps <- rbind(gps, gps_record)
  }
  data <- cbind(data, gps)
  
  # Leaflet map
  data$name <- as.character(data$name)
  path <- toGeoJSON(data, lat.lon=c(9,10), dest=tempdir())
  sty <- styleSingle(fill="red", fill.alpha=1, rad=2)
  map <- leaflet(path, dest=tempdir(), style = sty, popup = c("name", "radius"))
  map
}
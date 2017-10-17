library("sf")
library("devtools")
library("bcmaps")

set_utf8 <- function(sf_obj) {
  char_cols <- names(sf_obj)[vapply(sf_obj, is.character, FUN.VALUE = logical(1))]

  for (col in char_cols) {
    Encoding(sf_obj[[col]]) <- "UTF-8"
  }

  sf_obj
}

process_file <- function(file, transform = TRUE, repair = TRUE, clip_bc = FALSE) {
  obj <- sf::read_sf(file)
  
  if (transform) {
    obj <- bcmaps::transform_bc_albers(obj)
  }
  
  if (clip_bc) {
    obj <- sf::st_intersection(obj, bcmaps.rdata::bc_bound_hres)
  }
  
  if (repair) {
    obj <- bcmaps::fix_geo_problems(obj)
  }
  
  obj
}
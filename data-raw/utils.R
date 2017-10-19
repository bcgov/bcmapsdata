library("sf")
library("dplyr")
library("devtools")
library("bcmaps")

set_utf8 <- function(sf_obj) {
  char_cols <- names(sf_obj)[vapply(sf_obj, is.character, FUN.VALUE = logical(1))]

  for (col in char_cols) {
    Encoding(sf_obj[[col]]) <- "UTF-8"
  }

  sf_obj
}

#' Prepare a spatial file for inclusion in bcmaps.rdata package
#'
#' @param file path to shp or gdb
#' @param transform transform to BC Albers (default `TRUE`)
#' @param repair Repair toplogy (default `TRUE`)
#' @param filter_stmt An optional filter statement - bare, unquoted. E.g., `PRUID == 59`
#' @param clip_bc Does it require clipping to BC boundary? Default `FALSE`
#'
#' @return
#' @export
#'
#' @examples
process_file <- function(file, layer, transform = TRUE, repair = TRUE, filter_stmt, 
                         clip_bc = FALSE, crs = NULL) {
  
  obj <- sf::read_sf(file, layer = layer)
  
  if (!is.null(crs)) st_crs(obj) <- crs
  
  if (!missing(filter_stmt)) {
    f_q <- rlang::enquo(filter_stmt)
    obj <- dplyr::filter(obj, !!f_q)
  }
  
  if (transform) {
    obj <- bcmaps::transform_bc_albers(obj)
  }
  
  if (clip_bc) {
    obj <- sf::st_intersection(obj, bcmaps.rdata::bc_bound_hres)
  }
  
  if (repair) {
    if (!is.na(sf_extSoftVersion()["lwgeom"])) {
      obj <- sf::st_make_valid(obj)
    } else {
      obj <- bcmaps::fix_geo_problems(obj)
    }
  }
  
  obj
}

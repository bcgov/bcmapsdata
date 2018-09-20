# Copyright 2018 Province of British Columbia
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.

library(sf)
library(bcmaps)
library(rnaturalearth)
library(dplyr)


source("data-raw/utils.R")


# Draw square polygon to intersect full data ------------------------------

## Square box on projected surface
coords = list(matrix(c(-142, 59.9,
                       -137.69, 47,
                       -114.31, 47,
                       -110, 59.9,
                       -142, 59.9),
                     ncol = 2,
                     byrow = TRUE))

outside_bc_box <- st_polygon(coords) %>%
  st_sfc(crs = 4326) %>%
  transform_bc_albers() 

nw_prov_states <- ne_states(country = c("Canada","United States of America"), returnclass = "sf") %>% 
  filter(name %in% c("Washington","British Columbia","Idaho","Montana","Alberta","Yukon","Alaska","Northwest Territories")) %>% 
  transform_bc_albers()

bc_neighbours <- nw_prov_states %>% 
  st_intersection(outside_bc_box) %>% 
  select(iso_a2, name, type, postal) 

## Pull out a Pacific Ocean polygon and give it the same cols as bc_neighbours
bc_oceans <- outside_bc_box %>% 
  st_difference(bc_neighbours %>%
                  mutate(ID = 1) %>% 
                  group_by(ID) %>% 
                  summarise()) %>% 
  as.data.frame() %>% 
  st_as_sf() %>% 
  mutate(iso_a2 = "OC", name = "Pacific Ocean", type = "Ocean", postal = NA) 

## Bind the neighbours and ocean data together
bc_neighbours <- rbind(bc_neighbours, bc_oceans) %>% 
  as_tibble() %>% 
  st_as_sf()


use_data(bc_neighbours, overwrite = TRUE, compress = "xz")

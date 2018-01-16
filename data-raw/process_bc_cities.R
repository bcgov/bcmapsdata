# Copyright 2015 Province of British Columbia
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

source("data-raw/utils.R")

bc_cities_zip <- "data-raw/bc_cities/bc_cities.zip"

unzip(bc_cities_zip, exdir = "data-raw/bc_cities")

bc_cities <- process_file("data-raw/bc_cities/BC_MAJOR_CITIES_POINTS_500M.gdb")

use_data(bc_cities, overwrite = TRUE, compress = "xz")


## library(ggplot2)
#ggplot() +
#  geom_sf(data = bc_cities) +
#  geom_sf(data = bc_bound_hres(), alpha = 0.1)
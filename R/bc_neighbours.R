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


#' Boundary of British Columbia, provinces/states and the portion of the Pacific Ocean that borders British Columbia 
#'
#' Administrative boundaries and the Pacific Oceans surrounding and including British Columbia
#' bounded by a square projected box. This layer is primarily intended for plotting purposes. 
#'
#'
#' @details Downloaded from \href{https://www.naturalearthdata.com/}{Natural Earth} via
#' \href{https://github.com/ropensci/rnaturalearth}{rnaturalearth} and clipped to the area within a bounding box
#' then re-projected to BC Albers projection. Some attribute fields were removed, and other attribute 
#' field names were changed. Pacific Ocean polygon is generated as the difference between the terrestrial polygons 
#' and the bounding box
#'
#'

"bc_neighbours"

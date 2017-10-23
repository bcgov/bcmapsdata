# Copyright 2016 Province of British Columbia
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

gw_aquifers_zip <- "data-raw/gw_aquifers/BCGW_GW_AQUIFERS.zip"

unzip(gw_aquifers_zip, exdir = "data-raw/gw_aquifers")

gw_aquifers <- process_file("data-raw/gw_aquifers/GW_AQUIFER/GW_AQUIFER_polygon.shp")

use_data(gw_aquifers, overwrite = TRUE, compress = "xz")

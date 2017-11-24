# Copyright 2017 Province of British Columbia
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

water_precincts_zip <- "data-raw/water_precincts/water_precincts.zip"

unzip(water_precincts_zip, exdir = "data-raw/water_precincts")

water_precincts <- process_file("data-raw/water_precincts/LWADM_WATMGMT_PREC_AREA_SVW.gdb")

use_data(water_precincts, overwrite = TRUE, compress = "xz")

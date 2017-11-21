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

###############################################################################
## Get map of BC from Govt of Canada Open Data site:
## ("http://open.canada.ca/data/en/dataset/f77c2027-ed4a-5f6e-9395-067af3e9fc1e")

source("data-raw/utils.R")

unzip("data-raw/bec/bec.zip", exdir = "data-raw/bec")

bec <- process_file("data-raw/bec/BEC_BIOGEOCLIMATIC_POLY.gdb")

use_data(bec, overwrite = TRUE, compress = "xz")
file.rename("data/bec.rda", "data-extra/bec.rda")

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

airzones_databc <- "http://catalogue.data.gov.bc.ca/dataset/e8eeefc4-2826-47bc-8430-85703d328516/resource/4cea4b22-36a3-4ea7-9346-7e872e747076/download/bcairzonesalbersshp.zip"
airzones_dir <- "data-raw/airzones"
airzones_zip <- file.path(airzones_dir, "airzones.zip")

if (!file.exists(airzones_zip)) {
  download.file(airzones_databc, airzones_zip)
}

unzip(airzones_zip, exdir = airzones_dir)

airzones_shp <- list.files(airzones_dir, pattern = ".shp$", full.names = TRUE)

airzones <- process_file(airzones_shp)

use_data(airzones, overwrite = TRUE, compress = "xz")

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

rd_zip <- "data-raw/regional_districts/BCGW_REGIONAL_DISTRICTS_GDB.zip"
unzip(rd_zip, exdir = "data-raw/regional_districts")

regional_districts <- process_file("data-raw/regional_districts/ABMS_REGIONAL_DISTRICTS_SP.gdb")

use_data(regional_districts, overwrite = TRUE, compress = "xz")

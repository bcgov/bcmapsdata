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

municipalities_zip <- "data-raw/municipalities/BCGW_MUNICIPALITIES_GDB.zip"
unzip(municipalities_zip, exdir = "data-raw/municipalities")

municipalities <- process_file("data-raw/municipalities/ABMS_MUNICIPALITIES_SP.gdb")

use_data(municipalities, overwrite = TRUE, compress = "xz")

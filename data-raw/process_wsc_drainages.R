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

wsc_drainages_zip <- "data-raw/wsc_drainages/wsc_drainages.zip"

unzip(wsc_drainages_zip, exdir = "data-raw/wsc_drainages")

wsc_drainages <- process_file("data-raw/wsc_drainages/DRP_SUB_SUB_DRAINAGES_1M_SP.gdb")

## deal with a non ASCII character in the data
# wsc_drainages$WSCSSDA_EN <- iconv(wsc_drainages$WSCSSDA_EN, "UTF-8", sub = "")

use_data(wsc_drainages, overwrite = TRUE, compress = "xz")

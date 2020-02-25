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

library(bcdata)

nr_districts <- bcdc_get_data('0bc73892-e41f-41d0-8d8e-828c16139337')

class(nr_districts) <- setdiff(class(nr_districts), "bcdc_sf")

use_data(nr_districts, overwrite = TRUE, compress = "xz")

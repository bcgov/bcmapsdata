
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bcmapsdata

### Version 0.3.3

[![img](https://img.shields.io/badge/Lifecycle-Retired-d45500)](https://github.com/bcgov/repomountie/blob/master/doc/lifecycle-badges.md)
[![Travis-CI Build
Status](https://travis-ci.org/bcgov/bcmapsdata.svg?branch=master)](https://travis-ci.org/bcgov/bcmapsdata)

This is a package that contains many spatial layers for British
Columbia. It is a ‘backend’ data package to provide the layers available
in the [bcmaps](https://github.com/bcgov/bcmaps) package. We are
following the strategy recommended by [Anderson and
Eddelbuettel](https://journal.r-project.org/archive/2017/RJ-2017-026/index.html).

### Installation

#### Stable version

``` r
install.packages('bcmapsdata', repos='https://bcgov.github.io/drat/')
```

#### Development version

``` r
# install.packages("remotes")
remotes::install_github("bcgov/bcmapsdata")
```

#### Legacy version

Older builds of this package were called `bcmaps.rdata` and will work
with bcmaps version \<=0.17.1. Those builds can still be installed
using:

``` r
install.packages('bcmaps.rdata', repos='https://bcgov.github.io/drat/')
```

### Usage

This package is best used in conjunction with the
[bcmaps](https://github.com/bcgov/bcmaps). Please follow guidance there.

### Getting Help or Reporting an Issue

To report bugs/issues/feature requests, please file an
[issue](https://github.com/bcgov/%3Cpkg-name%3E/issues/).

### How to Contribute

If you would like to contribute to the package, please see our
[CONTRIBUTING](CONTRIBUTING.md) guidelines.

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.

#### Adding a new layer

To add a new layer to the package, there are several steps you need to
follow:

##### In the [data-raw](data-raw) directory:

1.  Create a new folder to hold the data as downloaded from its source.
    It is best if the data is available under an open licence such as
    the [Open Government Licence - British
    Columbia](https://www2.gov.bc.ca/gov/content?id=A519A56BC2BF44E4A008B33FCF527F61)
    or the [Open Government License -
    Canada](http://open.canada.ca/en/open-government-licence-canada).
    The data should be zipped up in a `.zip` file to minimize the size.
    In the directory add a `README.md` file explaining what the data is
    and where it comes from, a copy of the licence the data is under,
    and a `.gitignore` file that ignores all files except the zip file,
    the `README.md`, the licence file, and the `.gitignore` file.

2.  Create a `process_[my_layer].R` file in the root of the
    [data-raw](data-raw) directory. Use one of the existing files as a
    template. It should `source("data-raw/utils.R")` and use the
    `process_file()` function to do the basic processing:

<!-- end list -->

``` r
#' Prepare a spatial file for inclusion in bcmapsdata package
#'
#' @param file path to shp or gdb
#' @param transform transform to BC Albers (default `TRUE`)
#' @param repair Repair toplogy (default `TRUE`)
#' @param filter_stmt An optional filter statement - bare, unquoted. E.g., PRUID == 59
#' @param clip_bc Does it require clipping to BC boundary? Default `FALSE`
#'
#' @return processed sf object
process_file(file, layer, transform = TRUE, repair = TRUE, filter_stmt, 
                         clip_bc = FALSE, crs = NULL)
```

Use `devtools::use_data()` to save the processed file in the
[data](data) directory.

##### In the [R](R) directory:

1.  Create an R file for the documentation of the new layer. Use one of
    the existing R files as a template.
2.  Run `devtools::document()`

*Commit, push and make a pull request*

#### Optionally add a shortcut function to the frontend bcmaps package:

Install your local updated `bcmapsdata` package with
`devtools::install()` before moving on to the next steps

##### In the [bcmaps](https://github.com/bcgov/bcmaps) package:

1.  Run `devtools::load_all()` to load the local version of the package.

2.  Run the internal function `bcmaps:::make_shortcuts()` while in the
    bcmaps package directory, then run `devtools::document()`. This will
    automatically generate a shortcut function in `bcmaps` for your new
    dataset.

3.  Commit your changes and make a pull request to *bcmaps*.

### License

Please note that the data files in the data-raw directory and
subdirectories are licensed separately as they come from different
sources. See the approprate license file in each directory.

The code in this repository is licensed under the Apache License 2.0:

``` 
 Copyright 2017 Province of British Columbia
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and limitations under the License.
```

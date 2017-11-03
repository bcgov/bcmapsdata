<!-- README.md is generated from README.Rmd. Please edit that file -->
<a rel="Exploration" href="https://github.com/BCDevExchange/docs/blob/master/discussion/projectstates.md"><img alt="Being designed and built, but in the lab. May change, disappear, or be buggy." style="border-width:0" src="https://assets.bcdevexchange.org/images/badges/exploration.svg" title="Being designed and built, but in the lab. May change, disappear, or be buggy." /></a>

bcmaps.rdata
============

This is a package that contains many spatial layers for British Columbia. It is being built as a new 'backend' package to provide the layers available in the [bcmaps](https://github.com/bcgov/bcmaps) package.

### Installation

#### Stable version

``` r
# install.packages("drat")
drat::addRepo("bcgov")
install.packages("bcmaps.rdata")
```

#### Development version

``` r
# install.packages("remotes")
remotes::install_github("bcgov/bcmaps.rdata")
```

### Usage

### Project Status

This package is under active development, in conjunction with a rewrite of the **bcmaps** package. That development is ongoing under the [new-frontend branch](https://github.com/bcgov/bcmaps/tree/new-frontend).

### Getting Help or Reporting an Issue

To report bugs/issues/feature requests, please file an [issue](https://github.com/bcgov/%3Cpkg-name%3E/issues/).

### How to Contribute

If you would like to contribute to the package, please see our [CONTRIBUTING](CONTRIBUTING.md) guidelines.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

### License

Please note that the data files in the data-raw directory and subdirectories are licensed separately as they come from different sources. See the approprate license file in each directory.

The code in this repository is licensed under the Apache License 2.0:

     Copyright 2017 Province of British Columbia
     
     Licensed under the Apache License, Version 2.0 (the "License");
     you may not use this file except in compliance with the License.
     You may obtain a copy of the License at
     
     http://www.apache.org/licenses/LICENSE-2.0
     
     Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     See the License for the specific language governing permissions and limitations under the License.

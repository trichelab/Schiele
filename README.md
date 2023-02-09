[![Build Status](https://travis-ci.org/trichelab/Schiele.png?branch=master)](https://travis-ci.org/trichelab/Schiele)  [![codecov](https://codecov.io/gh/trichelab/Schiele/branch/master/graph/badge.svg)](https://codecov.io/gh/trichelab/Schiele)

# Schiele: like Seurat, but with... intensity. 

## what

Seurat got too comfortable. Time to go on a crash diet. Ultra-pre-alpha-beta.
At least it will read your feature count matrices into a SummarizedExperiment.
Later on we'll add some hooks to play nicely with Seurat-centric pipelines,
but without needing an 8XL instance to run on. 

## Installing

The pre-release version of the package can be pulled from GitHub using [remotes](https://cran.r-project.org/web/packages/remotes/) and/or [BiocManager](https://cran.r-project.org/web/packages/BiocManager). 

    # install.packages("remotes")
    # install.packages("BiocManager")
    BiocManager::install("trichelab/Schiele", build_vignettes=TRUE)

## Graphical Abstract

![Egon](inst/extdata/egon.jpg)

## For developers

The repository includes a Makefile to facilitate some common tasks.

### Running tests

`$ make test`. Requires the [testthat](https://github.com/hadley/testthat) package. You can also specify a specific test file or files to run by adding a "file=" argument, like `$ make test file=logging`. `test_package` will do a regular-expression pattern match within the file names. See its documentation in the `testthat` package.

### Updating documentation

`$ make doc`. Requires the [roxygen2](https://github.com/klutometis/roxygen) package.

#' Read a 10X-formatted .h5 file into a SummarizedExperiment
#' 
#' This function is useful for data processed by (e.g.) cellbender.
#' 
#' @param   path      path to the .h5 file
#' @param   splt      split by feature type, e.g. HTO vs. ADT? (FALSE)
#' @param   spcol     if splitting by feature type, which column to use? (3)
#' @param   verbose   be verbose? (TRUE)
#' 
#' @return            a SingleCellExperiment
#'
#' @import            DropletUtils
#' 
#' @export
sceH5 <- function(path, splt=FALSE, spcol=3, verbose=TRUE) {

  message("Reading ", path, "...")
  sce <- read10xCounts(path, type="HDF5")
  
  if (splt) {
    rowsplit <- with(files, read.table(features)[, spcol])
    dat <- split(dat, rowsplit)
  } 

}

#' a simple HTO demuxing function based on hashedDrops (support genotype later)
#' 
#' DropletUtils::hashedDrops assumes empty droplets have been removed. Schiele
#' assumes that sce will have colData column `keep` to indicate which cells,
#' and `keep` column will be a logical variable. To enforce these assumptions,
#' we refuse to attempt hash-tag oligo demuxing unless assumptions are met.
#' 
#' @param sce a SingleCellExperiment object with a colData column `keep`
#' @param hto a character vector of HTO names
#' @param ... additional arguments to be passed to \code{\link{hashedDrops}}
#' 
#' @return a SingleCellExperiment object with new colData columns (see Details)
#'
#' @details
#' The output of hashedDrops is placed in metadata(sce)$hashed, and three 
#' columns ("HTO", "Confident", "Doublet") are added to colData(sce).
#' For columns where `keep` is FALSE, these values are set to NA.
#' A note is also placed in metadata(sce) regarding the status of cells.
#' 
#' @seealso \code{\link{hashedDrops}}
#'
#' @import DropletUtils
#'
#' @export
demuxHashTags <- function(sce, hto=NULL, ...) { 

  message("See Schiele::pHTO() for a much faster implementation.")

  if (!"keep" %in% names(colData(sce))) {
    stop("colData(sce) must contain `keep`. Run markKept(sce) first.")
  }
  if (!is.logical(sce$keep)) {
    stop("colData(sce)$keep must be logical.")
  }

  kept <- colnames(sce)[which(sce$keep)]
  if (is.null(hto)) hto <- rownames(HTOs(sce))
  hd <- hashedDrops(HTOs(sce[, kept]), ...)
  metadata(sce)$hashed <- hd
  colData(sce)[, "HTO"] <- NA
  colData(sce)[kept, "HTO"] <- hto[hd[kept, "Best"]]
  colData(sce)[, "Confident"] <- NA
  colData(sce)[kept, "Confident"] <- hd[kept, "Confident"]
  colData(sce)[, "Doublet"] <- NA
  colData(sce)[kept, "Doublet"] <- hd[kept, "Doublet"]
  return(sce)

}

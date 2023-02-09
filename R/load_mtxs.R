#' Load a bunch of MatrixMarket triples (features, cells, matrix) into an SCE.
#' 
#' @param runs    a named vector of paths (if unnamed, try using the entries)
#' @param ...     arguments to pass on to load_mtx() 
#' @param BPPARAM if running in parallel, provide a MulticoreParam or similar
#' 
#' @return        a SingleCellExperiment
#' 
#' @import BiocParallel 
#' @import SummarizedExperiment
#' @import SingleCellExperiment
#' 
#' @export
load_mtxs <- function(runs, ..., BPPARAM=SerialParam()) {

  # sanity checking prior to processing  
  if (!is.null(names(runs))) {
    message("Auto-naming your runs. You probably won't like the results.")    
    names(runs) <- runs
  }

  # can parallelize here; do QC post-merge
  moby <- do.call(cbind, bplapply(runs, load_mtx, ..., BPPARAM=BPPARAM))
  as(SummarizedExperiment(list(counts=moby)), "SingleCellExperiment")

}

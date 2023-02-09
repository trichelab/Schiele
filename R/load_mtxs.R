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

  res <- bplapply(runs, load_mtx, ..., BPPARAM=BPPARAM)
  moby <- do.call(cbind, .rename_cells(res))
  as(SummarizedExperiment(list(counts=moby)), 
     "SingleCellExperiment")

}


# helper fn
.rename_cells <- function(objs) {
  stubs <- names(objs)
  names(stubs) <- stubs
  res <- lapply(seq_along(mapping), .rename, objs=objs, stubs=stubs)
  names(res) <- names(objs)
  return(res)
}

# helper fn
.rename <- function(i, objs, stubs, sep=",") {
  obj <- objs[[i]]
  stub <- stubs[i]
  colnames(obj) <- paste(stub, colnames(obj), sep=sep)
  return(obj)
}

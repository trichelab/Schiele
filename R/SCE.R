#' Load multiple count matrices into a SingleCellExperiment
#' 
#' @param runs    a named vector of paths (if unnamed, try using the entries)
#' @param verbose be verbose? (FALSE) 
#' @param ...     other arguments to pass on to loadMatrix() 
#' @param BPPARAM if running in parallel, provide a MulticoreParam or similar
#' 
#' @return        a SingleCellExperiment
#' 
#' @import BiocParallel 
#' @import SummarizedExperiment
#' @import SingleCellExperiment
#' 
#' @export
SCE <- function(runs, verbose=FALSE, ..., BPPARAM=SerialParam()) {

  # sanity checking prior to processing  
  if (is.null(names(runs))) names(runs) <- runs
  stopifnot(.runs_ok(runs))
  res <- bplapply(runs, loadMatrix, verbose=verbose, ..., BPPARAM=BPPARAM)
  res <- .rename_cells(res)
  res <- do.call(cbind, res)
  as(SummarizedExperiment(list(counts=res)), "SingleCellExperiment")

}


# helper fn
.rename_cells <- function(objs) {
  stubs <- names(objs)
  names(stubs) <- stubs
  res <- lapply(seq_along(stubs), .rename, objs=objs, stubs=stubs)
  names(res) <- names(objs)
  return(res)
}


# helper fn
.rename <- function(i, objs, stubs, sep=":") {
  obj <- objs[[i]]
  stub <- stubs[i]
  colnames(obj) <- paste(stub, colnames(obj), sep=sep)
  return(obj)
}


# helper fn
.runs_ok <- function(runs) {

  paths <- vapply(runs, dir.exists, logical(1))
  if (!all(paths)) {
    message("Some of your runs have missing output directories:")
    for (i in which(!paths)) message(names(runs)[i], ": ", runs[i])
    message("You should probably fix this before proceeding.")
    return(FALSE)
  } else { 
    return(TRUE)
  }

}

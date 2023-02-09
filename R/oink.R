#' Load some perfectly good data into a Seurat object. 
#' 
#' @param runs    a named vector of paths (if unnamed, try using the entries)
#' @param ...     arguments to pass on to load_mtxs()
#' 
#' @return        a Seurat object, if Seurat is (tragically) loaded
#' 
#' @export
oink <- function(runs, ...) {

  res <- load_mtxs(runs, ...) 
  if (requireNamespace("Seurat")) {
    res <- as(res, "Seurat")
  } else {
    message("Alas, Seurat could not be loaded.")
    message("There are many, many reasons this could happen.") 
    message("Fortunately, you will still receive a SingleCellExperiment!")
    message("Perhaps there is a reason people at (e.g.) Genentech use these.")
  }
  return(res)

}

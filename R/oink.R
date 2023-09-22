#' Load multiple count matrices into a Seurat object (perhaps)
#' 
#' @param runs    a named vector of paths (if unnamed, try using the entries)
#' @param ...     arguments to pass on to sce()
#' 
#' @return        a Seurat object, if Seurat is (tragically) loaded, else an sce
#' 
#' @export
oink <- function(runs, ...) {

  res <- sce(runs, ...) 
  if (requireNamespace("Seurat")) {
    return(as(res, "Seurat"))
  } else {
    message("Seurat could not be loaded. A dependency issue, perhaps?")
    message("Happily, you will still receive a SingleCellExperiment.")
    return(res)
  }

}

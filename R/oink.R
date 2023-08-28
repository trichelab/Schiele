#' Load multiple count matrices into a Seurat object (perhaps)
#' 
#' @param runs    a named vector of paths (if unnamed, try using the entries)
#' @param ...     arguments to pass on to SCE()
#' 
#' @return        a Seurat object, if Seurat is (tragically) loaded, else an SCE
#' 
#' @export
oink <- function(runs, ...) {

  res <- SCE(runs, ...) 
  if (requireNamespace("Seurat")) {
    return(as(res, "Seurat"))
  } else {
    message("Seurat could not be loaded. A dependency issue, perhaps?")
    message("Happily, you will still receive a SingleCellExperiment.")
    return(res)
  }

}

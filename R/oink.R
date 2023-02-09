#' Load some perfectly good data into a Seurat object. 
#' 
#' @param runs    a named vector of paths (if unnamed, try using the entries)
#' @param ...     arguments to pass on to load_mtxs()
#' 
#' @return        a Seurat object, if Seurat is (tragically) installed
#' 
#' @export
oink <- function(runs, ...) {

  res <- load_mtxs(runs, ...) 
  if (requireNamespace("Seurat")) {
    res <- as(res, "Seurat")
  } else {
    message("Alas, Seurat is not installed. Returning an SCE.")
  }
  return(res)

}

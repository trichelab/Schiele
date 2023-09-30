#' read in .h5 output, as from using cellbender on kallisto/kite .h5ad files.
#' 
#' @param path      path to cellbender or 10X (cellranger v3) .h5 file
#' @param splt      attempt to split HTOs from ADTs/mRNA? (only if found)
#' 
#' @return a SingleCellExperiment with a DelayedMatrix of counts
#' 
#' @import HDF5Array
#'
#' @export
sceH5 <- function(path, splt=TRUE) { 

  group <- "matrix"
  mat <- HDF5Array::TENxMatrix(path, group)

  cell.names <- as.character(h5read(path, paste0(group, "/barcodes")))
  stopifnot(length(cell.names) == ncol(mat))
  stopifnot(identical(colnames(mat), cell.names))

  gene.names <- as.character(h5read(path, paste0(group, "/features/name")))
  stopifnot(length(gene.names) == nrow(mat))
  rownames(mat) <- gene.names

  res <- as(SummarizedExperiment(list(counts=mat)), "SingleCellExperiment")
  rowData(res)$type <- ifelse(grepl("HTO", rownames(res)), "HTO", "ADTorGEX")
  if (splt) res <- .splitHTOs(res)
  return(res)

}


# helper fn
.splitHTOs <- function(res) { 
    
  if (any(rowData(res)$type == "HTO")) {
    res <- splitAltExps(res, rowData(res)$type)
    mainExpName(res) <- "ADTorGEX"
    altExpNames(res) <- "HTO"
  }
  return(res)

}



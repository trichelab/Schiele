#' accessor for the 'RNA' altExp in a sensibly processed SingleCellExperiment
#' 
#' Note that unlike ADTs and HTOs, the default assay is 'logcounts' for `mRNA`.
#'
#' @param sce a SingleCellExperiment, ideally one from \code{\link{SCE}}
#'
#' @return a matrix of RNA abundance, with rownames corresponding to genes
#' 
#' @seealso \code{\link{SCE}}
#' 
#' @import SingleCellExperiment
#'
#' @export
mRNA <- function(sce, a="logcounts") getExp(sce, "RNA", a)

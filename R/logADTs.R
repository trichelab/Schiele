#' logcounts for the 'ADT' altExp in a sensibly processed SingleCellExperiment
#' 
#' @param sce a SingleCellExperiment, ideally from sceMTX or sceH5
#'
#' @return a matrix of ADT logcounts, rownames corresponding to the ADT names
#' 
#' @seealso \code{\link{sceH5}}
#' 
#' @import SingleCellExperiment
#'
#' @export
logADTs <- function(sce) ADTs(sce, "logcounts")

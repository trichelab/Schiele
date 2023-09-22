#' accessor for the 'ADT' altExp in a sensibly processed SingleCellExperiment
#' 
#' @param sce a SingleCellExperiment, ideally one from \code{\link{sce}}
#'
#' @return a matrix of ADT counts, with rownames corresponding to the ADT names
#' 
#' @seealso \code{\link{sce}}
#' 
#' @import SingleCellExperiment
#'
#' @export
ADTs <- function(sce, a="counts") getExp(sce, "ADT", a)

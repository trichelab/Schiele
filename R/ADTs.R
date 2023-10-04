#' accessor for the 'ADT' altExp in a sensibly processed SingleCellExperiment
#' 
#' @param sce a SingleCellExperiment, ideally from sceMTX or sceH5
#'
#' @return a matrix of ADT counts, with rownames corresponding to the ADT names
#' 
#' @seealso \code{\link{sceH5}}
#' @seealso \code{\link{sceMTX}}
#' 
#' @import SingleCellExperiment
#'
#' @export
ADTs <- function(sce, a="counts") getExp(sce, "ADT", a)

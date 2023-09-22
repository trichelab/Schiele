#' accessor for the 'HTO' altExp in a sensibly processed SingleCellExperiment
#' 
#' @param sce a SingleCellExperiment, ideally one from \code{\link{sce}}
#'
#' @return a matrix of HTO counts, with rownames corresponding to the HTO names
#' 
#' @seealso \code{\link{demuxHashTags}}
#' @seealso \code{\link{pHTO}}
#' @seealso \code{\link{sce}}
#' 
#' @import SingleCellExperiment
#'
#' @export
HTOs <- function(sce, a="counts") getExp(sce, "HTO", a)

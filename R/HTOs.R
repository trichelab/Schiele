#' accessor for the 'HTO' altExp in a sensibly processed SingleCellExperiment
#' 
#' @param sce a SingleCellExperiment, ideally one from sceH5 or sceMTX
#'
#' @return a matrix of HTO counts, with rownames corresponding to the HTO names
#' 
#' @seealso \code{\link{demuxHashTags}}
#' @seealso \code{\link{sceMTX}}
#' @seealso \code{\link{sceH5}}
#' @seealso \code{\link{pHTO}}
#' 
#' @import SingleCellExperiment
#'
#' @export
HTOs <- function(sce, a="counts") getExp(sce, "HTO", a)

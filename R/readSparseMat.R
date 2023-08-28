#' read a MatrixMarket file and return a dgCMatrix with features as rows
#'
#' This is a wrapper around \code{\link{Matrix::readMM}} that returns a
#' \code{\link{dgCMatrix}} with features as rows. It is factored out solely
#' to isolate any fallout from changes to the \code{\link{Matrix}} package.
#'
#' @param   mat   path to a MatrixMarket file
#'
#' @return        a dgCMatrix
#'
#' @seealso       Matrix::readMM
#'
#' @import        Matrix
#'
#' @export
readSparseMat <- function(mat) as(t(readMM(mat)), "CsparseMatrix")

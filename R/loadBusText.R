#' Read a .bus.txt file produced by `bustools text`
#' 
#' This is rarely done in practice (BUS is more efficient) but useful for demos.
#'
#' @param   file      the bustools text file to import
#' 
#' @return            a data.frame 
#'
#' @details
#' This function works fine on gzipped files too.
#' 
#' @examples 
#' bus_txt <- system.file("extdata", "short.bus.txt.gz", package="Schiele")
#' bus <- loadBusText(bus_txt)
#' 
#' # how many fragments per cell? (low-pass CITEseq example)
#' summary(as.integer(with(bus, rowsum(count, barcode))))
#' 
#' # how many fragments per equivalence class (feature)?
#' summary(as.integer(with(bus, rowsum(count, set))))
#'
#' # how many equivalence classes (features) per cell?
#' summary(sapply(split(bus, bus$barcode), function(x) length(unique(x$set))))
#'
#' @export
loadBusText <- function(file) {

  read.table(file, header=FALSE, sep="\t", stringsAsFactors=FALSE, 
             col.names=c("barcode","umi","set","count")) # i.e., B, U, S, count

}

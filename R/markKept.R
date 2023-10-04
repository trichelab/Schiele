#' Attempt to call nonempty cells based on a target cell number from a kneeplot
#' 
#' Sometimes DropletUtils::emptyDrops() will fail, especially on shallow runs 
#' designed to determine if a CITEseq experiment is worth sequencing deeply. 
#' This can occur even when the shallow libraries are quite clean. Therefore, 
#' we provide this wrapper function to ease the pain of QC'ing shallow runs.
#'
#' @param sce           a SingleCellExperiment object
#' @param targetCells   the number of cells supposedly loaded (20000)
#' @param targetUMIs    minimum UMIs to aim for if UMIs[targetCells] is low (50)
#' @param column        optional colData name for cached results ("UMIs")
#' @param ...           additional arguments to perhaps pass to emptyDrops
#' 
#' @return a SingleCellExperiment object with a new column `keep`
#'
#' @seealso kneePlot
#' @seealso emptyDrops
#' 
#' @export
markKept <- function(sce, targetCells=20000, targetUMIs=50, column="UMIs", ...){

  if (!column %in% names(colData(sce))) {
    colData(sce)[[column]] <- colSums(counts(sce))
  }
  tally <- sort(colData(sce)[[column]], decreasing=TRUE)
  sat <- max(which(tally >= targetUMIs))
  intercept <- tally[targetCells]
  if (targetUMIs > intercept) {
    message("targetUMIs is higher than the UMI count (", intercept, 
            ") at targetCells!")
    message("Only ", sat, " cells have at least ", targetUMIs, " UMIs.")
    message("Setting `keep` to TRUE for these cells.")
    sce$keep <- (colData(sce)[[column]] >= targetUMIs)
  } else { 
    message("Your UMI count at targetCells is ", intercept, ".")
    message("You might consider running emptyDrops() on this dataset.")
    sce$keep <- (colData(sce)[[column]] >= intercept)
  }

  return(sce)

}

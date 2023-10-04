#' Create a halfway decent knee plot for shallow or deep single-cell seq runs
#' 
#' @param sce       A SingleCellExperiment object
#' @param target    The target number of cells (10000)
#' @param column    Optional colData name for precomputed results ("totalUMIs")
#' 
#' @return A ggplot2 object
#'
#' @import SingleCellExperiment
#' @import ggplot2
#' 
#' @export
kneePlot <- function(sce, target=10000, column="totalUMIs") {

  args <- paste(sapply(match.call()[-1], deparse)[1:2], collapse=", ")

  # don't recompute if already available
  if (column %in% names(colData(sce))) {
    message("Found ", column, " in names(colData); skipping recomputation.")
    args <- c(args, column) # only if it is actually used!
    knee <- data.frame(UMIs=colData(sce)[, column])
  } else { 
    message("Computing total UMIs per cell from counts matrix.")
    args <- c(args, "computed") # else note this 
    knee <- data.frame(UMIs=colSums(counts(sce)))
  }
  knee <- knee[order(knee$UMIs, decreasing=TRUE), , drop=FALSE]
  knee$rank <- seq_len(nrow(knee))
  cutoff <- knee[target, "UMIs"]

  title <- paste0("kneePlot(", args, ")")
  ggplot(subset(knee, UMIs > 0), 
         aes(x=rank, y=UMIs)) + 
    geom_hline(yintercept=cutoff, linewidth=0.5, linetype="dashed") + 
    geom_vline(xintercept=target, linewidth=0.5, linetype="dashed") +
    geom_line(linewidth=2, color="red") + 
    geom_point(color="blue", alpha=0.1) + 
    scale_y_continuous(trans = "log10", breaks = 10**seq(1, 5)) + 
    scale_x_continuous(trans = "log10", breaks = 10**seq(1, 5)) + 
    ylab("UMI count per droplet") + 
    xlab("Droplet rank") +
    theme_classic() + 
    ggtitle(title) +
    NULL

}

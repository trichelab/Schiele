#' generic mainExp/altExp getter
#'
#' If a named experiment isn't in the altExps of a SingleCellExperiment,
#' get the requested assay from the mainExp, iff mainExpName(sce) == e.
#' 
#' @param sce   a SingleCellExperiment
#' @param e     name of the experiment to get
#' @param a     name of the assay to get ("counts") 
#' 
#' @return      the contents of the requested assay for the requested experiment
#' 
#' @seealso HTOs
#' @seealso ADTs 
#' @seealso mRNA
#'
#' @import SingleCellExperiment
#'
#' @export
getExp <- function(sce, e, a="counts") { 

  if (!e %in% c(mainExpName(sce), altExpNames(sce))) {
    stop(paste0("Experiment ", e, " was not found in sce."))
  }
  if (mainExpName(sce) == e) {
    if (!a %in% assayNames(sce)) {
      stop("Assay ", a, " was not found in the main experiment of sce.")
    }
    assay(sce, a)
  } else if (e %in% altExpNames(sce)) {
    if (!a %in% assayNames(altExp(sce, e))) {
      stop("Assay ", a, " was not found in altExp(sce, \"", e, "\").")
    }
    assay(altExp(sce, e), a)
  } else { 
    stop("Something went wrong in getExp(sce, \"", e, "\", \"", a, "\").")
  }

}

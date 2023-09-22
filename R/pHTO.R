#' moronically simple function to calculate Pr(HTO=hto|counts)
#' 
#' Use a multinomial test to calculate HTO probability.
#'
#' @param sce   a SingleCellExperiment object with !is.null(altExp(sce, "HTO"))
#' @param off   offtarget probability (default is 0.1 total for all !whichHTO)
#'
#' @return      same sce but with new column "pHTO" (and "HTO" if not present)
#'
#' @export
pHTO <- function(sce, off=0.1) {

  if (!"keep" %in% names(colData(sce))) {
    stop("colData(sce) must contain `keep`. Run markKept(sce) first.")
  }
  if (!is.logical(sce$keep)) {
    stop("colData(sce)$keep must be logical.")
  }

  HTOnames <- rownames(HTOs(sce))
  if (!"HTO" %in% names(colData(sce))) {
    sce$HTO <- NA
    kept <- which(sce$keep)
    colData(sce)[kept, "HTO"] <- HTOnames[max.col(t(HTOs(sce[, kept])))]
  }
  whichHTO <- match(colData(sce)$HTO, HTOnames)
  toTest <- which(!is.na(whichHTO))
  names(toTest) <- colnames(sce)[toTest]
  whichHTO <- whichHTO[toTest]
  names(whichHTO) <- names(toTest)

  sce$pHTO <- NA
  sce$pHTO[toTest] <- .pHTO_chisq(HTOs(sce[, toTest]), whichHTO, off=off)
  return(sce)

}


# helper fn
.pHTO_chisq <- function(UMIs, whichHTO, off=0.1) {

  stopifnot(names(whichHTO) == colnames(UMIs)) 
  HTOnames <- rownames(UMIs)

  nHTOs <- nrow(UMIs)
  stopifnot(ncol(UMIs) == length(whichHTO)) 
  probs <- matrix(off / (nHTOs-1), nrow=nHTOs, ncol=nHTOs)
  rownames(probs) <- HTOnames
  colnames(probs) <- HTOnames
  diag(probs) <- 1 - off
  df <- nHTOs - 1
 
  # idea: cbind the observed and expected, then test 
  expected <- colSums(UMIs) * probs[whichHTO, ]
  rownames(expected) <- colnames(UMIs)
  colnames(expected) <- paste0("p", rownames(UMIs))
  oe <- cbind(as.matrix(t(UMIs)), expected)
  pchisq(.chisqstat(oe), df=df)

}


# helper fn
.chisqstat <- function(oe) { 

  oi <- grep("^[^p]", colnames(oe))
  ei <- grep("^p", colnames(oe))
  stopifnot(length(oi) == length(ei))
  stopifnot(!any(oi %in% ei))
  apply(oe, 1, function(oei) sum(((oei[oi] - oei[ei])**2) / (oei[ei])))

}

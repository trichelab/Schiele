% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sceH5.R
\name{sceH5}
\alias{sceH5}
\title{read in .h5 output, as from using cellbender on kallisto/kite .h5ad files.}
\usage{
sceH5(path, splt = TRUE)
}
\arguments{
\item{path}{path to cellbender or 10X (cellranger v3) .h5 file}

\item{splt}{attempt to split HTOs from ADTs/mRNA? (only if found)}
}
\value{
a SingleCellExperiment with a DelayedMatrix of counts
}
\description{
read in .h5 output, as from using cellbender on kallisto/kite .h5ad files.
}

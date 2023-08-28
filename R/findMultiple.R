#' see if a package is installed more than once
#' 
#' @param   pkg     name of the package
#'
#' @return  a data.frame with columns 'Package' and 'LibPath' of 0 or more rows
#' 
#' @examples
#' findMultiple("Seurat")
#'
#' @export
findMultiple <- function(pkg = "Seurat") { 

  installs <- subset(data.frame(library()$results[, 1:2]), Package == pkg)
  if (nrow(installs) > 1) {
    message("Warning: you have MULTIPLE installations of ", pkg, " visible")
    apply(installs, 1, .to_remove)
  }
  invisible(installs)

}


# helper
.to_remove <- function(x) { 
  pkg <- x["Package"]
  lib <- x["LibPath"]
  message("# to remove ", pkg, " from ", lib, ":")
  message("remove.packages(pkgs=\"", pkg, "\", lib=\"", lib, "\")")
}

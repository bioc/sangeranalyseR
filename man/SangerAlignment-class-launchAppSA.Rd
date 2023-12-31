% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MethodSangerAlignment.R
\name{SangerAlignment-class-launchAppSA}
\alias{SangerAlignment-class-launchAppSA}
\alias{launchAppSA,SangerAlignment-method}
\title{launchAppSA}
\usage{
\S4method{launchAppSA}{SangerAlignment}(object, outputDir = NULL, colors = "default")
}
\arguments{
\item{object}{A SangerAlignment S4 instance.}

\item{outputDir}{The output directory of the saved new SangerContig S4 instance.}

\item{colors}{A vector for users to set the colors of (A, T, C, G, else). 
There are three options for users to choose from. 
  1. "default":  (green, blue, black, red, purple). 
  2. "cb_friendly":  ((0, 0, 0), (199, 199, 199), (0, 114, 178), (213, 94, 0), (204, 121, 167)). 
  3. Users can set their own colors with a vector with five elements.}
}
\value{
A \code{shiny.appobj} object.
}
\description{
A SangerAlignment method which launches Shiny app for SangerAlignment instance.
}
\examples{
data("sangerAlignmentData")
RShinySA <- launchAppSA(sangerAlignmentData)
RShinySA <- launchAppSA(sangerAlignmentData, colors="cb_friendly")
}

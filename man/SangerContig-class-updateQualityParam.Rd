% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MethodSangerContig.R
\name{SangerContig-class-updateQualityParam}
\alias{SangerContig-class-updateQualityParam}
\alias{updateQualityParam,SangerContig-method}
\title{updateQualityParam}
\usage{
\S4method{updateQualityParam}{SangerContig}(
  object,
  TrimmingMethod = "M1",
  M1TrimmingCutoff = 1e-04,
  M2CutoffQualityScore = NULL,
  M2SlidingWindowSize = NULL,
  processorsNum = NULL
)
}
\arguments{
\item{object}{A SangerContig S4 instance.}

\item{TrimmingMethod}{The read trimming method for this SangerRead. The value must be \code{"M1"} (the default) or \code{'M2'}.}

\item{M1TrimmingCutoff}{The trimming cutoff for the Method 1. If \code{TrimmingMethod} is \code{"M1"}, then the default value is \code{0.0001}. Otherwise, the value must be \code{NULL}.}

\item{M2CutoffQualityScore}{The trimming cutoff quality score for the Method 2. If \code{TrimmingMethod} is \code{'M2'}, then the default value is \code{20}. Otherwise, the value must be \code{NULL}. It works with \code{M2SlidingWindowSize}.}

\item{M2SlidingWindowSize}{The trimming sliding window size for the Method 2. If \code{TrimmingMethod} is \code{'M2'}, then the default value is \code{10}. Otherwise, the value must be \code{NULL}. It works with \code{M2CutoffQualityScore}.}

\item{processorsNum}{The number of processors to use, or NULL (the default) for all available processors.}
}
\value{
A SangerContig instance.
}
\description{
A SangerContig method which updates QualityReport parameter for each the SangerRead instance inside SangerContig.
}
\examples{
data("sangerContigData")
\dontrun{
updateQualityParam(sangerContigData,
                   TrimmingMethod         = "M2",
                   M1TrimmingCutoff       = NULL,
                   M2CutoffQualityScore   = 40,
                   M2SlidingWindowSize    = 15)}
}

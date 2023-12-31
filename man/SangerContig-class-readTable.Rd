% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MethodSangerContig.R
\name{SangerContig-class-readTable}
\alias{SangerContig-class-readTable}
\alias{readTable,SangerContig-method}
\title{readTable}
\usage{
\S4method{readTable}{SangerContig}(object, indentation = 0)
}
\arguments{
\item{object}{A SangerContig S4 instance.}

\item{indentation}{The indentation for different level printing.}
}
\value{
None
}
\description{
A SangerContig method which generates summary table for SangerContig instance
}
\examples{
data(sangerReadFData)
data(sangerContigData)
data(sangerAlignmentData)
\dontrun{
readTable(sangerReadFData)
readTable(sangerContigData)
readTable(sangerAlignmentData)
}
}

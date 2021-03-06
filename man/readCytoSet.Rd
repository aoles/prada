\name{readCytoSet}
\alias{readCytoSet}
\title{Create a cytoSet object from one or more FCS 3.0 files}
\description{Create a cytoSet object from one or more FCS 3.0 files}
\usage{
  readCytoSet(files=NULL, path=".", pattern=NULL, phenoData, sep="\t", ...)
}
\arguments{
  \item{files}{Optional character vector with filenames}
  \item{path}{Directory where to look for the files}
  \item{pattern}{This argument is passed on to \code{\link[base]{dir}} (see
    details). }
  \item{phenoData}{Either an object of class \code{phenoData} or 
    \code{character}.}
  \item{sep}{Separator character that gets passed on to
    \code{\link[Biobase]{read.AnnotatedDataFrame}}.}
  \item{...}{Further arguments that get passed on to
    \code{\link[Biobase]{read.AnnotatedDataFrame}}, see details.}
}

\details{There are three different ways to specify the file names:
  
  First, if the argument \code{phenoData} is present and is of class
  \code{\linkS4class{AnnotatedDataFrame}}, then it is obtained
  from its column \code{name}. The column is mandatory, and an error
  will be generated if it is not there.  Alternatively, the argument
  \code{phenoData} can be of class \code{character}, in which case this
  function tries to read a \code{AnnotatedDataFrame} object from the
  file with that name by calling
  \code{\link[Biobase]{read.AnnotatedDataFrame}} with arguments
  \code{file.path(path, phenoData), ...}.
  
  Second, if the argument \code{phenoData} is not present and
  the argument \code{files} is not \code{NULL}, then \code{files}
  is expected to be a character vector with the file names.
  
  Third, if neither the argument \code{phenoData} is present nor
  \code{files} is not \code{NULL}, then the file names are obtained by
  calling   \code{dir(path, pattern)}.
}

\value{An object of class \code{\linkS4class{cytoSet}}.}

\author{Wolfgang Huber \url{http://www.ebi.ac.uk/huber}}
\seealso{\code{\link{readFCSdata}}}

\examples{
## Please see man page for cytoSet-class
}
\keyword{IO}


## How filenames are obtained:
## 1. check for column 'filename' in pData(phenoData). If that is not there,
## 2. check argument 'files'. If that is not there,
## 3. evaluate directories in 'path'

readCytoSet <- function(files=NULL, path=".", pattern=NULL, phenoData, sep="\t", ...) {
  if(!missing(phenoData)) {
    if(is.character(phenoData))
      phenoData = read.AnnotatedDataFrame(file.path(path, phenoData),
        header = TRUE, as.is = TRUE, sep=sep, ...)
    if(!is(phenoData, "AnnotatedDataFrame"))
      stop("Argument 'phenoData' must be of type 'AnnotatedDataFrame'.")
    #if(!("name" %in% colnames(pData(phenoData))))
    #  stop("'phenoData' must contain a column 'name'")
    if(!is.null(files))
      warning("Argument 'files' is ignored.")
    files <- gsub("\"", "", sampleNames(phenoData))
    pData(phenoData)$name <- files
    rbind(name="fileNames", varMetadata(phenoData))
  }

  if(is.null(files)) {
    files <- dir(path, pattern)
    if(length(files)<1)
      stop(paste("No (matching) files found in directory", path))
  }
  if(!is.character(files))
    stop("'files' must be a character vector")
  
  if(missing(phenoData))
    phenoData=new("AnnotatedDataFrame",
      data=data.frame(name=I(files)),
      varMetadata=data.frame(labelDescription="Name of the FCS 3.0 file", row.names="name"))
  
  ## now we have everything in place: files, and phenoData
  
  env <- new.env(hash=TRUE)
  cn <- empty <- NULL
  for(f in seq(along=files)) {
    x <- readFCS(file.path(path, files[f]))
    if(nrow(exprs(x))==0){
      empty <- c(empty, files[f])
      next}
    if(is.null(cn)) {
      cn <- colnames(x)
    } else {
      if(!identical(cn, colnames(x)))
        stop(paste(files[f], "has different 'colnames' than previously read files."))
    }
    colnames(x) <- NULL
    if("well.number" %in% colnames(pData(phenoData)))
      x@well <- as.integer(pData(phenoData)[f,"well.number"])
    else
      x@well <- as.integer(f)
    assign(files[f], x, envir=env, inherits=FALSE)
  }

  ## correct phenoData for case of empty FCS files
  
  if(!is.null(empty)){
    pDat <- as.data.frame(pData(phenoData)[!pData(phenoData)[,"name"]
                                           %in% empty,])
    colnames(pDat) <- colnames(pData(phenoData))                  
    phenoData <- new("AnnotatedDataFrame",
       data     = pDat, varMetadata = varMetadata(phenoData))
    warning(length(empty), " FCS files containing no data were omitted!",
            call.=FALSE)
  }
 
  return(new("cytoSet",
    frames    = env,
    phenoData = phenoData,
    colnames=cn))
}
  

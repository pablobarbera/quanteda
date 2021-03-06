
#' Truncate absolute filepaths to root filenames
#'
#' This function takes an absolute filepath and returns just the 
#' document name
#'
#' @param longFilenames Absolute filenames including a full path with directory
#' @return character vector of filenames withouth directory path
#' @export
#' @author Paul Nulty
#' @examples
#' \dontrun{
#' getRootFileNames('/home/paul/documents/libdem09.txt')
#' }
getRootFileNames <- function(longFilenames) {
  ## function to return just the filename, path not included
  ## might need to detect .Platform$OS.type to change the delimiter
  delim <- "/"
  osName <- (Sys.info()[['sysname']] )
  if (osName=="Windows") { delim <- "\\\\" }
  splitFilenames <- strsplit(longFilenames, delim)
  return(sapply(splitFilenames, tail, n=1))
}


#' load text files from disk into a vector of character vectors

#' points to files, reads them into a character vector of the texts
#' with optional names, default being filenames
#' returns a named vector of complete, unedited texts
#' 
#' @param filenames a vector of paths to text files
#' @param textnames names to assign to the texts
#' @param enc a value for encoding that is a legal value for \link{Encoding}
#' @param verbose If TRUE, print out names of files being read. Default is FALSE
#' @return character vector of texts read from disk
#' @author Paul Nulty
#' @export
#' @examples
#' \dontrun{
#' getTextFiles('/home/paul/documents/libdem09.txt')
#' }
getTextFiles <- function(filenames, textnames=NULL, enc="unknown", verbose=FALSE) {
  # verbose=TRUE (progress bar?)
  if(verbose) print(sprintf("Reading ... %s", filenames))
  # print(sprintf("Reading .. %s \n", filenames))
  textsvec <- c() 
  for (f in filenames) {
    textsvec <- c(textsvec, paste(suppressWarnings(readLines(f)), collapse="\n"))
  }
  # name the vector with the filename by default, otherwise assign "names"
  ifelse(is.null(textnames), 
         names(textsvec) <- getRootFileNames(filenames),
         names(textsvec) <- textnames)
   # apply encoding
   Encoding(textsvec) <- enc
#   
#   # convert to UTF-8 if enc is specified
#   if (enc != "unknown") {
#       textsvec <- iconv(textsvec, enc, "UTF-8")
#       if (verbose)
#           cat("note: converted texts from", enc, "to UTF-8.")
#   }
  
  return(textsvec)
}


#' loads all text files from a given directory
#' 
#' given a directory name, get a list of all files in that directory and load
#' them into a character vector using getTextFiles
#' 
#' 
#' @param dirname A directory path
#' @param pattern a \link[=regex]{regular expression} pattern match for the input
#'   file names
#' @param enc a value for encoding that is a legal value for \link{Encoding}
#' @return character vector of texts read from disk
#' @author Paul Nulty
#' @export
#' @examples
#' \dontrun{
#' getTextDir('/home/paul/documents/')
#' }
getTextDir <- function(dirname, pattern="\\.txt$", enc="unknown") {
  # get all files from a directory
  return(getTextFiles(list.files(dirname, pattern=pattern, full.names=TRUE), enc=enc) )
}

#' provides a gui interface to choose a gui to load texts from
#'
#' launches a GUI to allow the user to choose a directory from
#' which to load all files.
#' @return character vector of texts read from disk
#' @export
#' @author Paul Nulty
#' @examples
#' \dontrun{
#' getTextFiles('/home/paul/documents/libdem09.txt')
#' }
getTextDirGui <- function() {
  path <- file.choose()
  #get all files from a directory
  return(getTextDir(path))
}

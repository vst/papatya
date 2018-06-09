##' Renders the given Rhtml or Rmd file with knitr/rmarkdown to an
##' HTML file and sends the result as an HTTP response.
##'
##' @param file Path to the Rhtml or Rmd file.
##' @param ... Extra parameterst to be bassed to knitr (Actually
##'     rapache is just giving the environment parameter).
##' @return Nothing as HTTP response is sent during the function
##'     evaluation.
raknit <- function (file, ...) {
    ## Get the input extension:
    extension <- tools::file_ext(file)

    ## Create a temporaty file name:
    ofile <- tempfile(fileext=".html")

    ## Render to HTML as per extension (content written to temp file):
    if (extension == "Rhtml") {
        knitr::knit(input=file, output=ofile, quiet=TRUE, ...)
    } else {
        ## First, we need the interim .md file path:
        mdfile <- tempfile(fileext=".md")

        ## Knit the .md file:
        knitr::knit(input=file, output=mdfile, quiet=TRUE, ...)

        ## Go for the markdown->HTML conversion
        markdown::markdownToHTML(mdfile, ofile, encoding=getOption("encoding"))

        ## Remove the interim markdown file:
        unlink(mdfile)
    }

    ## Send content type:
    setContentType(type="text/html")

    ## Send content:
    sendBin(object=readBin(ofile, "raw", n=file.info(ofile)$size))

    ## Remove the temporary file:
    unlink(ofile)

    ## Done, return shunya:
    NULL
}

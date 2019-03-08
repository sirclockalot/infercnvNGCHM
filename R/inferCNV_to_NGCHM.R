
#' Function for Generating a next-generation heatmap
#'
#' @title ngchm() : generates next gen heatmap
#'
#' @param infercnv_obj An infercnv object
#'
#' @param out_dir  output directory (default: '.')
#'
#' @param title title of the interactive heatmap (default: "NGCHM")
#'
#' @param gene_symbol ##TODO  (default: NULL)
#'
#' @param path_to_shaidyMapGen path to the shaidyMapGen jar file (default: NULL)
#'
#' @param x.center (integer) Center expression value for heatmap coloring.
#'
#' @param x.range (integer) Values for minimum and maximum thresholds for heatmap coloring.
#'
#' @export
#'

ngchm <- function(infercnv_obj,
                       out_dir=".",
                       title="NGCHM",
                       gene_symbol=NULL,
                       path_to_shaidyMapGen=NULL,
                       x.range = NA,
                       x.center = NA) {

    if (!is.null(path_to_shaidyMapGen)) {
        shaidy.path <- unlist(strsplit(path_to_shaidyMapGen, split = .Platform$file.sep))
        if (!file.exists(path_to_shaidyMapGen) || tail(shaidy.path, n = 1L) != "ShaidyMapGen.jar"){
            error_message <- paste("Cannot find the file ShaidyMapGen.jar using the parameter \"path_to_shaidyMapGen\".",
                                   "Check that the correct pathway is being used.")
            flog.error(error_message)
            stop(error_message)
        }
    } else {
        path_to_shaidyMapGen <- Sys.getenv("SHAIDYMAPGEN")
        if (!file.exists(path_to_shaidyMapGen)){ ## check if envionrmental variable is passed
            error_message <- paste("Cannot find the file ShaidyMapGen.jar using SHAIDYMAPGEN.",
                                   "Check that the correct pathway is being used.")
            flog.error(error_message)
            stop(error_message)
        }
    }

    if (!requireNamespace("NGCHM", quietly=TRUE)) {
        stop("The \"NGCHM\" library is required to use \"-ngchm=TRUE\" but it is not available.", .call=FALSE)
    }

    flog.info("Creating NGCHM as infercnv.ngchm")
    Create_NGCHM(infercnv_obj = infercnv_obj,
                 path_to_shaidyMapGen = path_to_shaidyMapGen,
                 out_dir = out_dir,
                 title = title,
                 gene_symbol = gene_symbol,
                 x.range = x.range,
                 x.center = x.center)
}


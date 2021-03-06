#' Measures of network
#'
#' Classification task. The network measures represent the dataset as a graph 
#' and extract structural information from it. The transformation between raw 
#' data and the graph representation is based on the epsilon-NN algorithm. Next,
#' a post-processing step is applied to the graph, pruning edges between 
#' examples of opposite classes.
#'
#' @family complexity-measures
#' @param x A data.frame contained only the input attributes.
#' @param y A factor response vector with one label for each row/component of x.
#' @param measures A list of measures names or \code{"all"} to include all them.
#' @param formula A formula to define the class column.
#' @param data A data.frame dataset contained the input attributes and class.
#' @param eps The percentage of nodes in the graph to be connected.
#' @param summary A list of summarization functions or empty for all values. See
#'  \link{summarization} method to more information. (Default: 
#'  \code{c("mean", "sd")})
#' @param ... Not used.
#' @details
#'  The following measures are allowed for this method:
#'  \describe{
#'    \item{"G1"}{Average Density of the network (G1) represents the 
#'      number of edges in the graph, divided by the maximum number of edges 
#'      between pairs of data points.}
#'    \item{"G2"}{Clustering coefficient (G2) averages the clustering 
#'      tendency of the vertexes by the ratio of existent edges between its 
#'      neighbors and the total number of edges that could possibly exist 
#'      between them.}
#'    \item{"G3"}{Hubs score (G3) is given by the number of connections it  
#'      has to other nodes, weighted by the number of connections these 
#'      neighbors have.}
#'  }
#' @return A list named by the requested network measure.
#'
#' @references
#'  Gleison Morais and Ronaldo C Prati. (2013). Complex Network Measures for 
#'    Data Set Characterization. In 2nd Brazilian Conference on Intelligent 
#'    Systems (BRACIS). 12--18.
#'
#'  Luis P F Garcia, Andre C P L F de Carvalho and Ana C Lorena. (2015). Effect
#'    of label noise in the complexity of classification problems. 
#'    Neurocomputing 160, 108--119.
#'
#' @examples
#' ## Extract all network measures for classification task
#' data(iris)
#' network(Species ~ ., iris)
#' @export
network <- function(...) {
  UseMethod("network")
}

#' @rdname network
#' @export
network.default <- function(x, y, measures="all", eps=0.15, 
                            summary=c("mean", "sd"), ...) {

  if(!is.data.frame(x)) {
    stop("data argument must be a data.frame")
  }

  if(is.data.frame(y)) {
    y <- y[, 1]
  }

  y <- as.factor(y)

  if(min(table(y)) < 2) {
    stop("number of examples in the minority class should be >= 2")
  }

  if(nrow(x) != length(y)) {
    stop("x and y must have same number of rows")
  }

  if(measures[1] == "all") {
    measures <- ls.network()
  }

  measures <- match.arg(measures, ls.network(), TRUE)

  if (length(summary) == 0) {
    summary <- "return"
  }

  colnames(x) <- make.names(colnames(x), unique=TRUE)
  dst <- enn(x, y, eps*nrow(x))
  graph <- igraph::graph.adjacency(dst, mode="undirected", weighted=TRUE)

  sapply(measures, function(f) {
    measure = eval(call(paste("c", f, sep="."), graph))
    summarization(measure, summary, f %in% ls.network.multiples(), ...)
  }, simplify=FALSE)
}

#' @rdname network
#' @export
network.formula <- function(formula, data, measures="all", eps=0.15, 
                            summary=c("mean", "sd"), ...) {

  if(!inherits(formula, "formula")) {
    stop("method is only for formula datas")
  }

  if(!is.data.frame(data)) {
    stop("data argument must be a data.frame")
  }

  modFrame <- stats::model.frame(formula, data)
  attr(modFrame, "terms") <- NULL

  network.default(modFrame[, -1, drop=FALSE], modFrame[, 1, drop=FALSE],
    measures, eps, summary, ...)
}

ls.network <- function() {
  c("G1", "G2", "G3")
}

ls.network.multiples <- function() {
  c("G3")
}

enn <- function(x, y, e) {

  dst <- dist(x)

  for(i in 1:nrow(x)) {
    a <- names(sort(dst[i,])[1:e+1])
    b <- rownames(x[y == y[i],])
    dst[i, setdiff(rownames(x), intersect(a, b))] <- 0
  }

  return(dst)
}

c.G1 <- function(graph) {
  1 - igraph::graph.density(graph)
}

c.G2 <- function(graph) {
  1 - igraph::transitivity(graph, type="global", isolates="zero")
}

c.G3 <- function(graph) {
  #1 - mean(igraph::hub.score(graph)$vector)
  1 - igraph::hub.score(graph)$vector
}

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/neighborhood.R
\name{neighborhood}
\alias{neighborhood}
\alias{neighborhood.default}
\alias{neighborhood.formula}
\title{Measures of neighborhood}
\usage{
neighborhood(...)

\method{neighborhood}{default}(x, y, measures = "all", summary = c("mean", "sd"), ...)

\method{neighborhood}{formula}(formula, data, measures = "all", summary = c("mean", "sd"), ...)
}
\arguments{
\item{...}{Not used.}

\item{x}{A data.frame contained only the input attributes.}

\item{y}{A factor response vector with one label for each row/component of x.}

\item{measures}{A list of measures names or \code{"all"} to include all them.}

\item{summary}{A list of summarization functions or empty for all values. See
\link{summarization} method to more information. (Default: 
\code{c("mean", "sd")})}

\item{formula}{A formula to define the class column.}

\item{data}{A data.frame dataset contained the input attributes and class.}
}
\value{
A list named by the requested neighborhood measure.
}
\description{
Classification task. The Neighborhood measures analyze the neighborhoods of 
the data items and try to capture class overlapping and the shape of the 
decision boundary. They work over a distance matrix storing the distances 
between all pairs of data points in the dataset.
}
\details{
The following measures are allowed for this method:
 \describe{
   \item{"N1"}{Fraction of borderline points (N1) computes the percentage of 
     vertexes incident to edges connecting examples of opposite classes in 
     a Minimum Spanning Tree (MST).}
   \item{"N2"}{Ratio of intra/extra class nearest neighbor distance (N2)  
     computes the ratio of two sums: intra-class and inter-class. The former 
     corresponds to the sum of the distances between each example and its 
     closest neighbor from the same class. The later is the sum of the 
     distances between each example and its closest neighbor from another 
     class (nearest enemy).}
   \item{"N3"}{Error rate of the nearest neighbor (N3) classifier corresponds
     to the error rate of a one Nearest Neighbor (1NN) classifier, estimated 
     using a leave-one-out procedure in dataset.}
   \item{"N4"}{Non-linearity of the nearest neighbor classifier (N4) creates 
     a new dataset randomly interpolating pairs of training examples of the 
     same class and then induce a the 1NN classifier on the original data and
     measure the error rate in the new data points.}
   \item{"N5"}{Fraction of hyperspheres covering data (N5) builds 
     hyperspheres centered at each one of the training examples, which have 
     their radios growth until the hypersphere reaches an example of another 
     class. Afterwards, smaller hyperspheres contained in larger hyperspheres 
     are eliminated. N5 is finally defined as the ratio between the number of 
     the remaining hyperspheres and the total number of examples in the 
     dataset.}
   \item{"N6"}{Local Set Average Cardinality (N6) is based on Local Set 
     (LS) and defined as the set of points from the dataset whose distance of
     each example is smaller than the distance from the exemples of the 
     different class. LSC is the average of the LS.}
 }
}
\examples{
## Extract all neighborhood measures for classification task
data(iris)
neighborhood(Species ~ ., iris)
}
\references{
Albert Orriols-Puig, Nuria Macia and Tin K Ho. (2010). Documentation for the
   data complexity library in C++. Technical Report. La Salle - Universitat 
   Ramon Llull.

 Enrique Leyva, Antonio Gonzalez and Raul Perez. (2014). A Set of Complexity
   Measures Designed for Applying Meta-Learning to Instance Selection. IEEE
   Transactions on Knowledge and Data Engineering 27, 2, 354--367.
}
\seealso{
Other complexity-measures: 
\code{\link{balance}()},
\code{\link{correlation}()},
\code{\link{dimensionality}()},
\code{\link{featurebased}()},
\code{\link{linearity}()},
\code{\link{network}()},
\code{\link{smoothness}()}
}
\concept{complexity-measures}

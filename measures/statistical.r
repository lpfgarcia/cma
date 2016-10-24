# R Code
# Statlog Measures
# L. P. F. Garcia A. C. Lorena and M. de Souto 2016
# The set of measures from Statlog Project


s1 <- function(data) {
	ncol(data) -1 
}


s2 <- function(data) {
	nrow(data)
}


s3 <- function(data) {
	nlevels(data$class)
}


s4 <- function(data) {
	sum(sapply(data, is.numeric))
}


s5 <- function(data) {
	sum(sapply(data, is.factor)) - 1
}


s6 <- function(data) {
	s4(data)/s2(data)
}


s7 <- function(data) {
	s5(data)/s2(data)
}


s8 <- function(data) {
	aux = summary(data$class)/nrow(data)
	aux = c(min(aux), max(aux), mean(aux), sd(aux))
	return(aux)
}


s8 <- function(data) {
	
	aux = unlist(
		sapply(data, function(i) {
			if(is.numeric(i))
				abs(skewness(i, type = 1))
		})
	)

	aux = c(min(aux), max(aux), mean(aux), sd(aux))
	return(aux)
}
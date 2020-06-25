library(mixOmics)

input <- function(inputfile) {
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1];
  methodtype <<- parameters["type", 2]
  elements <<- read.table(parameters["files", 2]);
  design <<- read.csv(parameters["possibleconnections", 2], header=FALSE)
}

run <- function() {
  mydata <<- list(length=nrow(elements));
  taus <<- list(length=nrow(elements));
  for (i in 1:nrow(elements)) {
     csvfile <- elements[i, 1];
     name <- elements[i, 2];
     tau <- elements[i, 3];
     x <- read.csv(csvfile, header=TRUE);
     rownames(x) <- x[,1];
     x <- x[,-1];
     mydata[[i]] <<- x
     names(mydata)[i] <<- name
     taus[i] <<- tau
  }
}

output <- function(outputfile) {
   if (methodtype == "sparse") {
      result = wrapper.sgcca(X = mydata, design = design, tau = as.double(taus), ncomp = 2, scheme = "centroid");
   }
   else {
      result = wrapper.rgcca(X = mydata, design = design, tau = as.double(taus), ncomp = 2, scheme = "centroid");
   }
   plotVar(result, comp = c(1,2), block = c(1,2))
   for (i in 1:nrow(elements)) {
      write.csv(result$variates[[i]], paste(outputfile, names(mydata)[i], "csv", sep="."))
   }
}

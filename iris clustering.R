#loading the Iris data for analysis
rm(list=ls()) 
library(datasets)
data(iris)
summary(iris)

#loading the necessary libraries for clustering
library(cluster)
library(dendextend)
library(ggplot2)
library(purrr)


#Euclidean method for distance measurement
dist_iris = dist(iris, method = "euclidean")

#Average linkage for hierarchical clustering
hc_iris = hclust(dist_iris, method = "average")

#Dendrogram (tree diagram) using hcluster
dendro_iris = as.dendrogram(hc_iris)

plot(dendro_iris)

#Dendrogram with cutree
dendro_iris2 = color_branches(dendro_iris, h = 2)
plot(dendro_iris2)



#Silhouette method for clustering
sil_width = map_dbl(2:5, function(k) {
  model <- pam(iris, k = k)
  model$silinfo$avg.width
})

#dataframe with silouette values
silouetteMethod <- data.frame(
  k = 2:5, sil_width = sil_width
)

ggplot(silouetteMethod, aes(x = k, y = sil_width)) + 
  geom_line() + title("Silhouette clustering") +
  xlab("K, number of clusters") +
  ylab("Silhouette Width")


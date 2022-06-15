# install.packages('network', .libPaths(), repos='http://cran.us.r-project.org')
# install.packages('ergm', .libPaths(), repos='http://cran.us.r-project.org')
# install.packages('devtools', .libPaths(), repos='http://cran.us.r-project.org')

devtools::install_github('tedhchen/ergmWorkshopTools')

library(ergm)
library(ergmWorkshopTools)

data(mid_mat)
?mid_mat

options(repr.plot.width=10, repr.plot.height=10)
checkmat(mid_mat)

?network

nw <- network(mid_mat, directed = F)
nw

options(repr.plot.width=10, repr.plot.height=10)
par(mfrow = c(1, 1))
set.seed(210615); plot(nw)

data(mid_edgelist)
nw.b <- network(mid_edgelist, directed = F)
nw.b

options(repr.plot.width=20, repr.plot.height=10)
par(mfrow = c(1, 2))
set.seed(210615); plot(nw); plot(nw.b)

data(mid_node_attr)
head(mid_node_attr)
?mid_node_attr

mat <- matrix(0, ncol = 189, nrow = 189, dimnames = list(row.names(mid_node_attr), row.names(mid_node_attr)))
mat[1:10, 1:10]

for(i in 1:nrow(mid_edgelist)){
    mat[mid_edgelist[i, 1], mid_edgelist[i, 2]] <- 1
    mat[mid_edgelist[i, 2], mid_edgelist[i, 1]] <- 1
}

options(repr.plot.width=14, repr.plot.height=7)
par(mfrow = c(1, 2))
checkmat(mat);checkmat(mid_mat)

nw

nw%v%'vertex.names'

nw%v%'dem' <- mid_node_attr$'dem'
nw

nw%v%'dem'

options(repr.plot.width=10, repr.plot.height=10)
set.seed(210615); plot(nw, vertex.col = ifelse(nw%v%'dem', 2, 1)); legend('bottomright', legend = c('Democracy', 'Nondemocracy'), fill = c(2, 1), bty = 'n', cex = 1.1)

data(contig); data(joint_dem)

options(repr.plot.width=16, repr.plot.height=8)
par(mfrow = c(1, 2))
set.seed(210615); plot(network(contig, directed = F), sub = 'Contiguity', cex.sub = 2); plot(network(joint_dem, directed = F), sub = 'Joint-Democracy', cex.sub = 2)

?`ergm-terms`

search.ergmTerms(search = 'transitive')

m0 <- ergm(nw ~ edges + nodefactor('dem') + edgecov(joint_dem))
summary(m0)

dyad_df <- ergmMPLE(nw ~ edges + nodefactor('dem') + edgecov(joint_dem))
dyad_df$predictor

summary(glm(dyad_df$response ~ dyad_df$predictor - 1, weights = dyad_df$weights, family = 'binomial'))

m1 <- ergm(nw ~ edges + nodefactor('dem') + edgecov(joint_dem) + kstar(2), control = control.ergm(seed = 210616))

m1 <- ergm(nw ~ edges + nodefactor('dem') + edgecov(joint_dem) + gwdegree(decay = 0, fixed = T), control = control.ergm(seed = 210616))

summary(m1)

m2 <- ergm(nw ~ edges + nodefactor('dem') + edgecov(joint_dem) + gwdegree(decay = 0, fixed = T) + triangle, control = control.ergm(seed = 210616))

m2 <- ergm(nw ~ edges + nodefactor('dem') + edgecov(joint_dem) + gwdegree(decay = 0, fixed = T) + gwesp(decay = 0, fixed = T), control = control.ergm(seed = 210616))

summary(m2)

tenclique <- network(matrix(1, ncol = 10, nrow = 10), directed = T)
options(repr.plot.width=7, repr.plot.height=7)
set.seed(210615); plot(tenclique)

summary(tenclique ~ edges + gwesp(0, fixed = T) + gwesp(0.5, fixed = T) + gwesp(1, fixed = T) + gwesp(2, fixed = T) + gwesp(5, fixed = T) + gwesp(10, fixed = T) + ttriple)

m2.b <- ergm(nw ~ edges + nodefactor('dem') + edgecov(joint_dem) + gwdegree(decay = 0.2, fixed = T) + gwesp(decay = 0, fixed = T), control = control.ergm(seed = 210616))

summary(m2.b)

m2fit <- gof(m2, control = control.gof.ergm(seed = 210616))
m2fit

options(repr.plot.width=32, repr.plot.height=8)
par(mfrow = c(1, 4))
plot(m2fit)

m1fit <- gof(m1, control = control.gof.ergm(seed = 210616))
options(repr.plot.width=32, repr.plot.height=8)
par(mfrow = c(1, 4))
plot(m1fit)

summary(m2)

tri <- matrix(c(0, 1, 1,
                1, 0, 0,
                1, 0, 0), byrow = T, ncol = 3)
nw.tri <- network(tri, directed = F)
nw.tri%v%'dem' <- c(0, 1, 1)
jd.tri <- matrix(c(0, 0, 0,
                   0, 0, 1,
                   0, 1, 0), byrow = T, ncol = 3)
options(repr.plot.width=10, repr.plot.height=10)
set.seed(210615); plot(nw.tri, vertex.col = ifelse(nw.tri%v%'dem', 2, 1), displaylabels = T)

ergmMPLE(nw.tri ~ edges + nodefactor('dem') + edgecov(jd.tri) + gwdegree(decay = 0, fixed = T) + gwesp(decay = 0, fixed = T))$predictor

round(coefficients(m2), 2)

plogis(-1.76)

m2.c <- ergm(nw ~ edges + nodefactor('dem') + edgecov(joint_dem) + gwdegree(decay = 0, fixed = T) + gwesp(decay = 0, fixed = T),
             eval.loglik = F,
             control = control.ergm(seed = 210615,
                                    MCMC.burnin = 50000,
                                    MCMC.samplesize = 4000,
                                    MCMC.interval = 4000,
                                    parallel = 0))

summary(m2.c)

m2.c <- logLik(m2.c, add = T)

summary(m2.c)

options(repr.plot.width=20, repr.plot.height=10)
mcmc.diagnostics(m2)

options(repr.plot.width=20, repr.plot.height=10)
mcmc.diagnostics(m2.c)

###@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@######################################### 
# Assesing MCMC convergence for the Time divergence + topology estimation of #
# Using RWTY (Are we there yet?!)
#
###########

# installing packages, don't run everytime
install.packages("devtools")
library(devtools)
#install_github("danlwarren/RWTY")
library(rwty)
#install.packages('MCMCtreeR')
library(MCMCtreeR)
devtools::install_github("cmt2/revgadgets") 
library(revgadgets)
library(ggplot2)


PATH = "//Users/ixchel/Documents/Teaching/Evolution_workshop/tutorial"
setwd(PATH)


#Read the output from RevBayes
my_chains <- load.multi("output/try_real_6_new_data",
                        format= "revbayes") #so cool revbayes is an option!


#Analize the chains
tomatoes.rwty <- analyze.rwty( my_chains, fill.color = 'Likelihood', burnin = 201)

# some plots
tomatoes.rwty$topology.trace.plot
tomatoes.rwty$treespace.heatmap
tomatoes.rwty$treespace.points.plot

#Get an approximate of the topological ESS
topo.ess <- topological.approx.ess(my_chains, burnin = 500)


# some trees:
library(RevGadgets)

### Making a plot

file <- "output/try_real_2/MCC_tree.tre"

# read in the tree 
tree <- readTrees(paths = file)

# plot the FBD tree
plotTree(tree = tree, 
            timeline = T,
         geo_units = list("epochs", "periods"),
         node_age_bars = T,
         age_bars_colored_by = "posterior",
         tip_labels_italics = T) + 
  theme(legend.position=c(.05, .6),
        legend.background = element_rect(fill="transparent"))


#Root age plot

chain_1 <- "output/timetree_aytoniaceae_run_1.log"
chain_2 <- "output/timetree_aytoniaceae_run_2.log"

#read trace

trace_1 <- readTrace(paths = chain_1, burnin = 0.1)
trace_2 <- readTrace(paths = chain_2, burnin = 0.1)

plotTrace(trace=trace_2, vars = "root_time")[[1]]

summarizeTrace(trace = trace_1, vars = "root_time")
summarizeTrace(trace = trace_2, vars = "root_time")

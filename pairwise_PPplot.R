# generate PP plot from Homo v1.3 output data
# created by WRF 2018-10-09

args = commandArgs(trailingOnly=TRUE)

inputfile = args[1]
#inputfile = "~/supplements/whelan_2015/16/whelan_d16_reorder_summary.csv"
outputfile = gsub("([\\w/]+)\\....$","\\1_PP-plot.pdf",inputfile,perl=TRUE)

d <- read.table(inputfile, header=FALSE, skip=9, sep=",")

### observed probability taken directly from csv data table
Pobs = d[,5]
ncomps = length(Pobs)

sorted_Pobs = sort(Pobs, decreasing=TRUE, index.return=TRUE)

### expected probability assumes even distribution between 0 and 1
Pexp = 1 - ( seq(1,ncomps) / (ncomps + 1) )

# estimate of alpha value based on number of points
bluecolor = paste("#034e7b",as.hexmode(as.integer( 255/sqrt(ncomps)+32 )),sep="")
colorvec = rep(bluecolor,ncomps)

### CHECK FOR OPTIONAL SECOND FILE OF TAXA GROUPS
# in format of:
# taxon    grp_number

taxa_file = args[2]
if (!is.na(taxa_file)) {
taxa_tabs = read.table(taxa_file, header=FALSE, sep="\t")
#taxa_tabs = read.table("~/supplements/whelan_2015/16/whelan_d16_taxonomy_groups.tab", header=FALSE, sep="\t")
species1 = d[,1]
sp1_groups = taxa_tabs[,2][match(species1,taxa_tabs[,1])]
species2 = d[,2]
sp2_groups = taxa_tabs[,2][match(species2,taxa_tabs[,1])]
same_group = (sp1_groups==sp2_groups)[sorted_Pobs$ix]
colorvec[same_group] = "#e31a1c44"
}

#
# generate PDF output 
#
pdf(height=6, width=6, file=outputfile)
par(mar=c(4.5,4.5,2,2))
#plot(d$pe, d$po, ylab="p (obs)", xlab="p (exp)", main="PP plot", xlim=c(0,1), ylim=c(0,1), pch=20)
plot(Pexp, sorted_Pobs$x, ylab="p (obs)", xlab="p (exp)", main=paste("PP plot of",inputfile), xlim=c(0,1), ylim=c(0,1), pch=16, cex=1.1, cex.lab=1.4, cex.axis=1.4, col=colorvec)
abline(0, 1, h=0.05, lwd=1)

if (!is.na(taxa_file)) {
legend(0,1,legend=c("Within group","Between groups"),pch=16, col=c("#e31a1cbb","#034e7baa"),bty="n", cex=1.5)
}

dev.off() 








#
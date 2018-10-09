# plot p-values as a heatmap from the program Homo
# created by WRF 2018-10-09

args = commandArgs(trailingOnly=TRUE)

inputfile = args[1]
#inputfile = "~/supplements/whelan_2015/16/whelan_d16_reorder_Pvalues.csv"
outputfile = gsub("([\\w/]+)\\....$","\\1_heatmap.pdf",inputfile,perl=TRUE)

d <- read.table(inputfile, header=FALSE, skip=1, sep=",", row.names=1)

ntaxa = length(d)

logd = -log(unlist(d),base=10)
range(logd)
logd[logd>10]=10.0


m1 = matrix(logd, ncol=ntaxa, byrow=FALSE)
m2 = m1[,ntaxa:1]

darkgreen = "#00441b"
darkpurple = "#44001b"


pdf(file=outputfile, width=10, height=8)
par(mar=c(2,12,2,1))
image(z=m2, col=colorRampPalette(c("#f7fcfd",darkpurple))(21),axes=FALSE, main=inputfile)
mtext(rev(row.names(d)),side=2,at=seq(0,1,1/(ntaxa-1)), las=1, cex=0.75)
# draw legend outside of plot boundaries
par(xpd=TRUE)
# middle of bottom row is y-value 0, so offset is needed to correctly place legend
yoffset = 0.6/ntaxa
legend(0,0-yoffset, legend=c("p ~ 1", expression(paste("p << 1", e^-10)) ), pch=22, pt.bg=c("#f7fcfd",darkpurple), cex=1.2, bty='n', horiz=TRUE)
dev.off()



#
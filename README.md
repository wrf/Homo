# Homo v.13 #

Details about how to compile, install and use Homo Version 1.3 are available in the manual.
Please direct errors, concerns and questions about the program to lars.jermiin@anu.edu.au

## generating plots of results ##
Several potential analyses were presented in the manual, which can be created for any dataset by directly using the output files from `Homo`.

1) Run `Homo` normally on a dataset, for instance, here using Dataset 16 from [Whelan et al 2015](https://figshare.com/articles/Error_signal_and_the_placement_of_Ctenophora_sister_to_all_other_animals/1334306).

2) Generate a PP plot using the R script `pairwise_PPplot.R`. The input is the `summary.csv` file from Homo and the output `.pdf` is automatically named as `PP-plot.pdf`.

   `Rscript pairwise_PPplot.R whelan_d16_reorder_summary.csv`

   The above command produces a PDF of the graph, named `whelan_d16_reorder_summary_PP-plot.pdf`.

![whelan_d16_reorder_summary_PP-plot.png](https://github.com/wrf/Homo/blob/master/examples/whelan_d16_reorder_summary_PP-plot.png)

3) Generate a heatmap of the p-values using the R script `pvalue_heatmap.R`. The input is the `Pvalues.csv` file and the output is automatically named as `heatmap.pdf`.

   `Rscript pvalue_heatmap.R whelan_d16_reorder_Pvalues.csv`

![whelan_d16_reorder_Pvalues_heatmap.png](https://github.com/wrf/Homo/blob/master/examples/whelan_d16_reorder_Pvalues_heatmap.png)

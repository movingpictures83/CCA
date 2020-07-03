# CCA
# Language: R
# Input: TXT
# Output: PREFIX
# Tested with: PluMA 1.1, R 4.0.0
# Dependency: mixOmics_6.12.1

PluMA plugin to perform Canonical Correlation Analysis (Gonzalez et al, 2008),
which can be used across multiple datasets and use principle components to
help estimate correlations.

The plugin accepts as input a TXT file of parameters, tab-delimited:
files: A TXT file containing multiple CSV files, each measuring a different
quantity over a set of samples.  In each file, rows are assumed to be samples
and columns measurements - so each file must have the same number of rows
type: regular or sparse
possibleconnections: A CSV file representing possible connections as a binary matrix.
Entry (i, j) is 1 if there is a possible connection between measurements i and j.
Note this order should match the order in files - i.e. element #2 here corresponds
to the second entry in the "files" file.

The TXT file provided to files has the following format on each line:
<CSV file> <name of variable> <regularize, 0 or 1>

Each variable should be given a unique name.  Regularize should be set to false (0)
for binary data (i.e. healthy or sick) or other discrete measurements.  Continuous
data should be regularized.

A plot will be produced of each measurements along the top two principal components,
and additionally one output file per variable (prefix.variable.csv) will be generated
with principal component values.

Note: Input CSV files were generated from the "nutrimouse" dataset, available
with mixOmics.  Regular and Sparse CCA are also part of the mixOmics library (Rohart et al, 2017).

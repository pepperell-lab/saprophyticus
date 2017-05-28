# saprophyticus
Data and scripts associated with 'Adaptation of Staphylococcus saprophyticus at the host-pathogen interface'.

#### accessions.txt
Accession numbers for sequence data used in this study.

#### strain_description.txt
Table with metadata for all S. saprophyticus genomes used in these analyses.

### alignments
#### masked\_sapro\_merged\_072516\_withRef.fasta
An alignment of _S. saprophyticus_ with ATCC15305 as the reference genome. Genomes were
assembled via mapping with BWA MEM 0.7.12 and variants calls with Pilon v 1.16. When reads were unavailable, draft genomes were aligned to ATCC15305 with Mugsy v 1.2.3. Repetitive regions in this alignment are masked with '-'.

#### sapro\_merged\_072516\_withRef.fasta
An alignment of _S. saprophyticus_ with ATCC15305 as the reference genome. Genomes were
assembled via mapping with BWA MEM 0.7.12 and variants calls with Pilon v 1.16. When reads were unavailable, draft genomes were aligned to ATCC15305 with Mugsy v 1.2.3.

#### sapro\_merged\_7-28-16.vcf.gz
VCF was created from masked\_sapro\_merged\_072516\_withRef.fasta using snp-sites v 2.3.2 using the option to remove sites with a gap (-c). The VCF was compressed using bgzip.

#### sapro\_merge\_7-28-16.vcf.gz.tbi
Index of VCF created with tabix.

### annotations
Contains .gff files for each de novo assembly created with Prokka v 1.11

### egglib
Population genetics statistics calculated with EggLib v 2.1.10. 
#### sample\_pi.txt
Sliding window pi values when 10 isolates are randomly sampled.
#### sampled\_tajimasD.txt
Sliding window Tajima's D values when 10 isolates are randomly sampled.
#### sampled\_theta.txt
Sliding window theta values when 10 isolates are randomly sampled.
#### windowStats\_masked\_lineageU.txt
Sliding window pi, theta, and Tajima's D for lineage U.
#### windowStats\_masked\_sapro\_merged\_withRef\_101216.txt
Sliding window pi, theta, and Tajima's D for all S. saprophyticus.

### elisa
Data from ELISA measuring Aas peptide to fibronectin and thrombospondin.

### figures
Manuscript figures.

### reference
Contains ATCC15305 reference genome

### scripts
R scripts to plot data.

### trees
#### RAxML\_bipartitionsBranchLabels.sapro\_101216\_combine
Newick tree from maximum likelihood phylogenetic inference with RAxML v 8.0.6.

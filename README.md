# saprophyticus
Data and scripts associated with S. saprophyticus selection project

###alignments
####masked\_sapro\_merged\_072516\_withRef.fasta
An alignment of _S. saprophyticus_ with ATCC15305 as the reference genome. Genomes were
assembled via mapping with BWA MEM 0.7.12 and variants calls with Pilon v 1.16. When reads were unavailable, draft genomes were aligned to ATCC15305 with Mugsy v 1.2.3. Repetitive regions in this alignment are masked with '-'.

####sapro\_merged\_072516\_withRef.fasta
An alignment of _S. saprophyticus_ with ATCC15305 as the reference genome. Genomes were
assembled via mapping with BWA MEM 0.7.12 and variants calls with Pilon v 1.16. When reads were unavailable, draft genomes were aligned to ATCC15305 with Mugsy v 1.2.3.

####sapro\_merged\_7-28-16.vcf.gz
VCF was created from masked\_sapro\_merged\_072516\_withRef.fasta using snp-sites v 2.3.2 using the option to remove sites with a gap (-c). The VCF was compressed using bgzip.

####sapro\_merge\_7-28-16.vcf.gz.tbi
Index of VCF created with tabix.

###annotations
Contains .gff files for each de novo assembly created with Prokka v 1.11

###reference
Contains ATCC15305 reference genome



wget ftp.sra.ebi.ac.uk/vol1/fastq/SRR256/091/SRR25604691/SRR25604691.fastq.gz
wget ftp.sra.ebi.ac.uk/vol1/fastq/SRR256/092/SRR25604692/SRR25604692.fastq.gz
wget ftp.sra.ebi.ac.uk/vol1/fastq/SRR256/093/SRR25604693/SRR25604693.fastq.gz
wget ftp.sra.ebi.ac.uk/vol1/fastq/SRR256/095/SRR25604695/SRR25604695.fastq.gz
wget ftp.sra.ebi.ac.uk/vol1/fastq/SRR256/097/SRR25604697/SRR25604697.fastq.gz
wget ftp.sra.ebi.ac.uk/vol1/fastq/SRR256/094/SRR25604694/SRR25604694.fastq.gz
wget ftp.sra.ebi.ac.uk/vol1/fastq/SRR256/090/SRR25604690/SRR25604690.fastq.gz
wget ftp.sra.ebi.ac.uk/vol1/fastq/SRR256/096/SRR25604696/SRR25604696.fastq.gz

## Rename files
mv -v SRR25604691.fastq.gz   RNA-NitrogenPlus-rep1.fastq.gz
mv -v SRR25604690.fastq.gz   RNA-NitrogenPlus-rep2.fastq.gz
mv -v SRR25604695.fastq.gz   RNA-NitrogenMinus-rep1.fastq.gz
mv -v SRR25604694.fastq.gz   RNA-NitrogenMinus-rep2.fastq.gz

mv -v SRR25604693.fastq.gz   Ribo-NitrogenPlus-rep1.fastq.gz
mv -v SRR25604692.fastq.gz   Ribo-NitrogenPlus-rep2.fastq.gz
mv -v SRR25604697.fastq.gz   Ribo-NitrogenMinus-rep1.fastq.gz
mv -v SRR25604696.fastq-2.gz Ribo-NitrogenMinus-rep2.fastq.gz

sample,fastq_1,fastq_2,strandedness,type,treatment,pair,GSM
RNA-NitrogenPlus-rep1,fastq/RNA-NitrogenPlus-rep1.fastq.gz,,forward,rnaseq,NitrogenPlus,1,GSM7703762
RNA-NitrogenPlus-rep2,fastq/RNA-NitrogenPlus-rep2.fastq.gz,,forward,rnaseq,NitrogenPlus,2,GSM7703763
RNA-NitrogenMinus-rep1,fastq/RNA-NitrogenMinus-rep1.fastq.gz,,forward,rnaseq,NitrogenMinus,3,GSM7703758
RNA-NitrogenMinus-rep2,fastq/RNA-NitrogenMinus-rep2.fastq.gz,,forward,rnaseq,NitrogenMinus,4,GSM7703759
Ribo-NitrogenPlus-rep1,fastq/Ribo-NitrogenPlus-rep1.fastq.gz,,forward,riboseq,NitrogenPlus,1,GSM7703760
Ribo-NitrogenPlus-rep2,fastq/Ribo-NitrogenPlus-rep2.fastq.gz,,forward,riboseq,NitrogenPlus,2,GSM7703761
Ribo-NitrogenMinus-rep1,fastq/Ribo-NitrogenMinus-rep1.fastq.gz,,forward,riboseq,NitrogenMinus,3,GSM7703756
Ribo-NitrogenMinus-rep2,fastq/Ribo-NitrogenMinus-rep2.fastq.gz,,forward,riboseq,NitrogenMinus,4,GSM7703757
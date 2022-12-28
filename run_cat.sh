rm 2209S002.fastq* 2209S003.fastq*
find ./fastq*/barcode09/ -type f \
| while read -r file; do zcat -f "$file" >> 2209S002.fastq; done && pigz -p 20 2209S002.fastq
find ./fastq*/barcode10/ -type f \
| while read -r file; do zcat -f "$file" >> 2209S003.fastq; done && pigz -p 20 2209S003.fastq

rm 220728_S002.fastq* 220728_S003.fastq*
find ./*/barcode07/ -type f \
| while read -r file; do zcat -f "$file" >> 220728_S002.fastq; done && pigz -p 20 220728_S002.fastq
find ./*/barcode08/ -type f \
| while read -r file; do zcat -f "$file" >> 220728_S003.fastq; done && pigz -p 20 220728_S003.fastq

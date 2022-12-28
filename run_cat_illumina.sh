#!/bin/bash
sample1=$(basename $1 | cut -d'_' -f 2 | sed 's/S//')
sample2=$(basename $2 | cut -d'_' -f 2| sed 's/S//')
dir=$(dirname $1)
prefix_a=$(basename $1 | cut -d'_' -f 1)
prefix_b=$(basename $1 | cut -d'_' -f 4)
prefix_a1=$(basename $2 | cut -d'_' -f 1)
prefix_b1=$(basename $2 | cut -d'_' -f 4)

# if [ $prefix_a!=prefix_a1 ] || [ $prefix_b!=prefix_b1 ]; then
# 	echo "ERROR, check the sample"
# 	exit 1
# fi

sample_merge=$(awk "BEGIN {print int(($sample1+$sample2)+22)}")
echo -e $sample1
echo -e $sample2
echo -e $sample_merge
zcat $1 $2 | pigz -p 20 > ${dir}/${prefix_a}_S${sample_merge}_L001_${prefix_b}_001.fastq.gz
cd ${dir}
cd ..
mkdir -p 0.fastq_backup
mv $1 $2 0.fastq_backup

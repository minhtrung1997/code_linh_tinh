if [ ! -s .${1}_${2}.list ]; then
	esearch -db sra -query $1 | efetch -format runinfo | cut -d ',' -f 1 | grep SRR > .${1}_${2}.list
	prefetch --option-file .${1}_${2}.list -p -O ${1}_${2}
	find ./${1}_${2} -maxdepth 2 -type f -print0 | xargs -0 mv -t ./${1}_${2}
	find ./${1}_${2} -type d -empty -delete
fi

if [ ! -s ".download_done_for_${1}" ]; then
	for file in $(find ./${1}_${2} -maxdepth 1 -type f -name *.sra); do
		prefix=a=${file%.*}
		echo -e "Downloading ${prefix} of sample $2..."
		fasterq-dump --threads 16 --split-files $file -O ./${1}_${2}
	done
	pigz -p 12 ./${1}_${2}/*.fastq
	touch ".download_done_for_${1}"
fi

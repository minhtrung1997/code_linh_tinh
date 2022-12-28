date_prefix=$(date +"%Y_%m_%d-%I_%M_%p")
bcl2fastq -R $1 --output-dir $2 --sample-sheet $3 --loading-threads 10 --processing-threads 20 --writing-threads 10 --no-lane-splitting
exec &> >(tee -a $2/"$date_prefix.bcllog")

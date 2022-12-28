#Copy RawFastq
for i in $(awk -F '\t' '{print $3}' $1); do 
	prefix=$(echo $(basename -s .fastq.gz $i) | sed 's/_S.*//')
	echo $prefix
	echo $i
	mkdir -p $2/$prefix/RawFastq
	cp $i $2/$prefix/RawFastq
done

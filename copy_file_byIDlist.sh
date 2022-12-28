#Copy file by ID list in fastANI, often for top20 ANI in SNP_analysis of bacteria
#USAGE: copy_file_byIDlist.sh <Seqdir> <IDlist> <Destination>

mkdir -p $3
for id in $(cat $2); do
	echo $id
	cp $1/$id* $3
done
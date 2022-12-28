Seq_path=$1
assembly=$2
dir_work=$(dirname $assembly)
find $Seq_path -type f -maxdepth 1 | grep '.fna\|.fasta' > $dir_work/ref.link
##Running FASTANI to choose the 10 nearest genomes### Just run this if we want to TAXONOMY very dilligently hard samples

fastANI -t 16 -q $assembly --rl $dir_work/ref.link -o $dir_work/ANI.tab

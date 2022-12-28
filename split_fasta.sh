out=$(dirname $1)/result

seqkit split2 --by-size 1 $1 -O $out

find $out -name "*.fasta" \
    | while read f; do \
        mv $f $out/$(seqkit seq --name --only-id $f).fasta; \
    done

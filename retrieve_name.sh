if [ -z $3 ]; then
    for acc in $(awk '{ print $2 }' $1); do
        acc_name=$(esearch -query $acc -db $2 \
        | esummary | xtract -pattern DocumentSummary -element Title -element SubType -element SubName | awk -v OFS="\t" '{print $0}') \
        && sed -i -e "s^$acc^${acc}\t${acc_name}^g" $1 \
        && echo $acc_name
    done
else
    backuptree=$(dirname $3)
    echo -e "cp $3 $backuptree/backuptree"
    mkdir -p $backuptree/backuptree && cp $3 $backuptree/backuptree
    for acc in $(awk '{ print $2 }' $1); do
        acc_name=$(esearch -query $acc -db $2 \
        | esummary | xtract -pattern DocumentSummary -element Title | sed 's/ /_/g;s/\t/_/g') \
        && sed -i -e "s^${acc}^${acc}--${acc_name}^g" $3 \
        && echo $acc_name
    done
fi

#| sed 's/ /_/g;s/\t/_/g;s/\;/_/g;s/(/</g;s/)/>/g')
#retrieve_name.sh <tab_file (Fastani)> <database>
# or ... retrieve_name.sh <tab_file (Fastani)> <database> <nwk.tree>

###Bacteria
## xtract -pattern DocumentSummary -element Organism -element Sub_type -element Sub_value | sed 's/ /_/g;s/\t/_/g'
### Virus (name)
## xtract -pattern DocumentSummary -element Title | sed 's/ /_/g;s/\t/_/g'
### Virus (name, host and country)
## xtract -pattern DocumentSummary -element Title -element SubName | awk -F'[\t|]' -v OFS="\t" '{print $1,$6,$3,$5}' | sed 's/ /_/g'
### Virus safe choice 
# xtract -pattern DocumentSummary -element Title -element SubType -element SubName | awk -v OFS="\t" '{print $0}'

## Unknown
#xtract -pattern DocumentSummary -element Organism -element SubType -element Sub_value | sed 's/ /_/g;s/\t/_/g;s/(/</g;s/)/>/g;s/:/|/g;s/\;/_/g'
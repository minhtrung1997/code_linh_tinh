directory=$1
pattern1=$2
pattern2=$3
for file in $(find $directory -type f,d -name *$pattern1*); do 
    newname=$(basename $file | sed "s/$pattern1/$pattern2/")
    mv $file $directory/$newname
    echo $directory/$newname
done
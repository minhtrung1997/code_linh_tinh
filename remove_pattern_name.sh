directory=new_name/
mkdir -p $directory
for file in $(ls *.fna); do 
    newname=RS_$(basename -s .fna $fna | sed 's/\_ASM.*$//')
    cp $fna $directory/$newname.fna
done
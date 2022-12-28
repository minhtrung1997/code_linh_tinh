# USAGE bash rclone.sh <source> <dest> <mode>
date_prefix=$(date +"%Y_%m_%d_%I-%M-%p")
if [ $3=="Copy" ]; then
        rclone copy $1 $2 -P --drive-chunk-size 128M --max-backlog 999999 --log-file=mylogcopyfile-${date_prefix}.txt --log-level INFO ; mv mylogcopyfile-${date_prefix}.txt $2
else
        rclone move $1 $2 -P --drive-chunk-size 128M --max-backlog 999999 --copy-links --log-file=mylogmovefile-${date_prefix}.txt --log-level INFO --delete-empty-src-dirs ; mv mylogmovefile-${date_prefix}.txt $2
fi        
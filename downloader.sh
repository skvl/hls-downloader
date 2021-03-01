#/usr/bin/env bash

set -Eeuo pipefail

INPUT_FILE=${1}

# while read p; do
#   echo "$p"
# done <${LIST}

mapfile -t urls < ${INPUT_FILE}
idx=3

for i in "${urls[@]}"
do
    echo "Download video #${idx} : ${i}"
    m3u8_file="${idx}.m3u8"
    mp4_file="${idx}.mp4"
    wget ${i} -O ${m3u8_file}
    ffmpeg -protocol_whitelist file,http,https,tcp,tls,crypto -i ${m3u8_file} -acodec copy -vcodec copy ${mp4_file}
    idx=$((idx+1))
done
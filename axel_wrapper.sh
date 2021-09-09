#!/bin/bash -eu

COMPRESSED_EXT=("7z zip iso rar tar.gz z")
DOCUMENT_EXT=("doc docx odt htm html pdf xls xlsx ods ppt pptx txt")
PROGRAM_EXT=("deb exe")
MUSIC_EXT=("mp3")
VIDEO_EXT="3g2 3gp amv asf avi drc flv f4v f4p f4a f4b gif gifv m4v mkv mng mov mp4 mpg mpeg MTS M2TS mxf nsv ogv ogg rm rmvb roq svi viv vob webm wm yuv"


cd ~/Downloads
mkdir -p Compressed
mkdir -p Documents
mkdir -p Programs
mkdir -p Music
mkdir -p Video

INPUT_INDEX=0
input_list=()
while true; do
    if [[ $INPUT_INDEX == "$#" ]]; then
        break
    fi
    INPUT_INDEX=$((INPUT_INDEX + 1))
    input_list+="${!INPUT_INDEX} "
done

if [[ $INPUT_INDEX -gt 0 ]]; then
    URL=$1
    removed_qeury=$(echo $URL | cut -d ? -f 1)
    filename=$(basename -- "$removed_qeury")
    extension="${filename##*.}"

    if [[ $(echo $COMPRESSED_EXT | grep -o "$extension" | wc -l) -gt 0 ]]; then
        cd Compressed
    fi
    if [[ $(echo $DOCUMENT_EXT | grep -o "$extension" | wc -l) -gt 0 ]]; then
        cd Documents
    fi
    if [[ $(echo $PROGRAM_EXT | grep -o "$extension" | wc -l) -gt 0 ]]; then
        cd Programs
    fi
    if [[ $(echo $MUSIC_EXT | grep -o "$extension" | wc -l) -gt 0 ]]; then
        cd Music
    fi
    if [[ $(echo $VIDEO_EXT | grep -o "$extension" | wc -l) -gt 0 ]]; then
        cd Video
    fi

    echo
    echo "Donwloading in $PWD ..."
    echo
    echo $input_list
    axel $input_list
else
    axel
fi

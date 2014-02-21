#!/bin/bash

#unalias date

#DATE=$(date "+%Y")
DATE=$(date -I)
#TIME=$(date "+%H:%M")
DIRECTORY=/home/pi/camera/images_$DATE
#DIRECTORY=/home/pi/camera/temp


# check if DIRECTORY exist
if [ ! -d "$DIRECTORY" ]; then 
	echo "Error, directory not exist!"
	exit 1
fi


# check if DIRECTORY is empty

FORMAT=jpg #png,bmp,jpg,gif
#FORMAT="${FILE##*.}"
#FILE=$DIRECTORY/$FILENAME.$FORMAT 
#COUNT=$(($(ls $DIRECTORY | wc -l)+1))

if [ ! "$(ls -A $DIRECTORY/*.$FORMAT 2> /dev/null)" ]; then
	echo "Directory is empty";
	exit 2
fi

# get image resolution from EXIF, only jpeg or jpg
#identify -format "%[EXIF:ImageLength] Image_%04d.$FORMAT
#identify -format "%[EXIF:ImageWidth] Image_%04d.$FORMAT

#echo "ffmpeg -framerate 10 -i $DIRECTORY/Image_%04d.$FORMAT -s:v 750:750 -c:v libx264 -crf 23 -pix_fmt yuv420p $DIRECTORY/video_$DATE.mp4"
#ffmpeg -framerate 10 -i $DIRECTORY/Image_%04d.$FORMAT -s:v 750:750 -c:v libx264 -crf 23 -pix_fmt yuv420p $DIRECTORY/video_$DATE.mp4
#echo "avconv -r 10 -i $DIRECTORY/Image_%04d.$FORMAT -r 10 -vcodec libx264 -crf 20 -g 15 $DIRECTORY/video_$DATE.mp4"
avconv -r 10 -i $DIRECTORY/Image_%04d.$FORMAT -r 10 -vcodec libx264 -crf 20 -g 15 $DIRECTORY/video_$DATE.mp4


echo "done"

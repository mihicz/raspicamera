#!/bin/bash

#unalias date

#DATE=$(date "+%Y")
DATE=$(date -I)
#TIME=$(date "+%H:%M")
DIRECTORY=/home/pi/camera/images_$DATE
#DIRECTORY=/home/pi/camera/temp

# check if DIRECTORY exist
if [ ! -d "$DIRECTORY" ]; then 
	mkdir -p $DIRECTORY
fi

COUNT=$(($(ls $DIRECTORY | wc -l)+1))
FILENAME=Image_$(printf "%04d" $COUNT)
#FILENAME=Image%04d
FORMAT=jpg #png,bmp,jpg,gif
FILE=$DIRECTORY/$FILENAME.$FORMAT 

# check if FILENAME exist
# if file exist then increase COUNT number
#while [ -f "$DIRECTORY/$FILENAME.$FORMAT" ]; do
#	COUNT=$(( $COUNT+1 ));
#	FILENAME=Image_$(printf "%04d" $COUNT);
#	if (( $COUNT == 20 )); then
#		echo "Error: full directory.";
#		exit;
#	fi
#done

# *** TAKE A PICTURE ***

# max 2592x1944 px
WIDTH=750
HEIGHT=750

# time in ms
# time before takes picture
# default 5s, min 30ms, 0 = wait forever
TIMEOUT=500 #0.5s
#SETTINGS="-ex fixedfps -awb off -ifx none"
#SETTINGS="-awb off -ifx none"
#SETTINGS="-awb cloud -ifx none" # obrazky neblikaji, ale prilis svetle
SETTINGS="-awb shade -ifx none"


#raspistill -o img7.jpg -r -v -t 500 -w 200 -h 200 >&img7.log 2>&1
#raspistill -o img20.png -e png -ex backlight -awb shade
#raspistill -o Image%04d.png -e png -w $width -h $height -t $timeout -tl $timelapse
#raspistill -o $DIRECTORY/$FILENAME.$FORMAT -e $FORMAT -w $WIDTH -h $HEIGHT -t $TIMEOUT -ex verylong

raspistill -o $FILE -e $FORMAT -w $WIDTH -h $HEIGHT -t $TIMEOUT $SETTINGS

# *** INSERT TIMESTAMP TO IMAGE ***

# see http://www.imagemagick.org/script/escape.php
#identify -format "$[EXIF:*]" Image.jpg
IMAGE_TEXT="%[EXIF:DateTimeOriginal]"
convert $FILE \
	-fill white -undercolor '#000A' \
	-pointsize 25 -annotate +1+21 "$IMAGE_TEXT" \
	$FILE

echo "done"

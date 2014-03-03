#!/bin/bash

#unalias date

DATE=$(date -I)
DIRECTORY=/home/pi/camera/timelapse_$DATE
#DIRECTORY=/home/pi/temp/timelapse_$DATE
FORMAT=jpg #png,bmp,jpg,gif
COUNT=0

# check if DIRECTORY exist
if [ ! -d "$DIRECTORY" ]; then 
	mkdir -p $DIRECTORY
fi

# max 2592x1944 px
WIDTH=750
HEIGHT=750
TIMEOUT=0s
SETTINGS="-ev -2 -awb auto"

# read exif information
IMAGE_TEXT="%[EXIF:DateTimeOriginal]"

# delay time
TIMELAPSE=10s

# calculate end time
#END_TIME="2014-03-03 21:06:00"
END_TIME=`date +%Y-%m-%d`\ "16:00:00"
echo $END_TIME
t1=`date --date="$END_TIME" +%s` # get seconds since epoch

while true; do

	# end condition
	CUR_TIME=`date +%Y-%m-%d\ %H:%M:%S`
	echo $CUR_TIME
	t2=`date --date="$CUR_TIME" +%s`
	if [ $t2 -ge $t1 ]; then
		break;
	fi

	COUNT=$(( $COUNT+1 ));
	FILENAME=Image_`printf %04d $COUNT`
	FILE=$DIRECTORY/$FILENAME.$FORMAT 
	echo $FILE

	# take a picture
	raspistill -o $FILE -e $FORMAT -w $WIDTH -h $HEIGHT -t $TIMEOUT $SETTINGS

	# convert image
#	convert $FILE \
#		-auto-level \
#		-fill white -undercolor '#000A' -pointsize 25 -annotate +1+745 "$IMAGE_TEXT" \
#		$FILE

	# wait
	sleep $TIMELAPSE;
done


echo "done"

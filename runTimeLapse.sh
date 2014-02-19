#!/bin/bash

#unalias date

#DATE=$(date "+%Y.%m.%d_%H:%M")
DATE=$(date "+%Y%m%d_%H%M")
#DATE=$(date "+%Y")
DIRECTORY=/home/pi/camera/timelapse_$DATE
FILENAME=Image%04d
FORMAT=png #png,bmp,jpg,gif

# check if DIRECTORY exist
if [ -d "$DIRECTORY" ]; then 
	echo "DIR exist"
	exit 0; 
fi
mkdir -p $DIRECTORY

# max 2592x1944 px
WIDTH=500
HEIGHT=500

# time in ms
TIMELAPSE=10000 #10s, >6s
#TIMELAPSE=30000 #30s, >6s
#TIMELAPSE=60000 #1m, >6s

#TIMEOUT=20000 #10s, >timelapse
TIMEOUT=120000 #2m, >timelapse
#TIMEOUT=900000 #15m, >timelapse
#TIMEOUT=3600000 #1h, >timelapse


#raspistill -o img7.jpg -r -v -t 500 -w 200 -h 200 >&img7.log 2>&1
#raspistill -o img20.png -e png -ex backlight -awb shade

#raspistill -o Image%04d.png -e png -w $width -h $height -t $timeout -tl $timelapse
#raspistill -o $DIRECTORY/$FILENAME.$FORMAT -e $FORMAT -w $WIDTH -h $HEIGHT -t $TIMEOUT -tl $TIMELAPSE -rot 180 -awb off
raspistill -o $DIRECTORY/$FILENAME.$FORMAT -e $FORMAT -w $WIDTH -h $HEIGHT -t $TIMEOUT -tl $TIMELAPSE -awb off
echo "done"

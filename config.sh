#!/bin/bash

#Script made for storing the users preference

rm -f config.txt


#FFmpeg don't come with an alias, sometimes
echo "If ffmpeg in your system has an alias, skip this passage"
echo "Do you wat to use the 'ffmpeg' alias?"
read YN
if [ "$YN" == "n" ]; then
echo "Standard ffmpeg directory is ~/bin"
DIR_FFMPEG="$HOME""/bin"
echo "Change it? (y = si, * = no)"
read YN
if [ "$YN" == "y" ]; then
    YN='';
    while [ "$YN" != "y" ]; do
	echo "Insert chosen directory"
	read -e DIR_FFMPEG
	
	if [ "$DIR_FFMPEG" == "yolo" ]; then #My ffmpeg folder is different, and I don't want to re-type everytime the folderm while debugging
	    DIR_FFMPEG="$HOME""/Programmi/Compilati/ffmpeg/bin"
	fi

	echo "You chose the folder: $DIR_FFMPEG"
	ls "$DIR_FFMPEG"
	echo "Is it ok? (y = si, * = no)"
	read YN

    done
fi
    DIR_FFMPEG="$DIR_FFMPEG"/
fi

DIR_OUTPUT=""$HOME"/Musica"
echo "Standard music directory is ~/Musica"
echo "Modify it? (y = si, * = no)"
read YN

if [ "$YN" == "y" ]; then
    YN='';
    while [ "$YN" != "y" ]; do
        echo "Insert chosen directory"
        read -e DIR_OUTPUT
	if [ "$DIR_OUTPUT" == "yolo" ]; then #Same as ffmpeg
	    DIR_OUTPUT="/media/nas/Musica"
	fi
        echo "You choose the directory: $DIR_OUTPUT"
	ls "$DIR_OUTPUT"
	echo "Is it ok? (y = si, * = no)"
        read YN
    done
    echo "DIR_OUTPUT" $DIR_OUTPUT >> log.txt
fi

echo "Select encoder and destination format"
echo
echo "	(a) libopus	(e) libmp3lame	(i) vorbis	" #Tab for showing what encoder are possible
echo "	(b) libvorbis	(f) libfaac	(l) mp2		"
echo "	(c) libfdk_aac	(g) eac3/ac3	(m) wmav2/wmav1	"
echo "	(d) aac		(h) libtwolame			"
echo
PROFILE=''
read ENCODER
case "$ENCODER" in #Just reciclyng a variable
	a) 	ENCODER='libopus';
		EXTENSION='opus';;
	b) 	ENCODER='libvorbis';
		EXTENSION='ogg';;
	c) 	ENCODER='libfdk_aac'; #Damn you, fdk_aac
		echo "What profile do you want to use?"
		echo
		echo "	(*) Standard	(1) aac_he	(2) aac_he_v2	"
		read PROFILE
		case $PROFILE in
			1) PROFILE="-profile:a aac_he";;
			2) PROFILE="-profile:a aac_he_v2";;
			*) PROFILE="";;
		esac;
		EXTENSION='m4a';;
	d) 	ENCODER='aac';
		EXTENSION='m4a';;
	e) 	ENCODER='libmp3lame';
		EXTENSION='mp3';;
	f) 	ENCODER='libfaac';
		EXTENSION='m4a';;
	g) 	ENCODER='eac3/ac3';
		EXTENSION='ac3';;
	h) 	ENCODER='libtwolame';
		EXTENSION='mp2';;
	i)	ENCODER='vorbis';
		EXTENSION='ogg';;
	l) 	ENCODER='mp2';
		EXTENSION='mp2';;
	m) 	ENCODER='wmav2/wmav1';
		EXTENSION='wmv';;
esac
echo
echo
echo "Select bitrate (Write only the number)"
echo
echo "	16Kb/s	64Kb/s	160Kb/s	" #You can write every number, but those tabs are cool
echo "	32Kb/s	96Kb/s	192Kb/s	"
echo " 	48Kb/s	128Kb/s	320Kb/s	"
echo
read BITRATE


echo "File di configurazione per lo script, modificare i valori o eseguire lo script 'config.sh'" >> config.txt
echo "FFMPEG =" $DIR_FFMPEG >> config.txt
echo "OUTPUT =" $DIR_OUTPUT >> config.txt
echo "ENCODER =" $ENCODER >> config.txt
echo "EXTENSION =" $EXTENSION >> config.txt
echo "PROFILE =" $PROFILE >> config.txt
echo "BITRATE =" $BITRATE >> config.txt

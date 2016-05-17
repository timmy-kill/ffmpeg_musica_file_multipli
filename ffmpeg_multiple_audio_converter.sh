#!/bin/bash

clear
echo "Script per l'organizzazzione dei file musicali"
echo

while [ "$yn" != "y" ]; do
        echo "Inserire la directory in cui sono locati i file musicali"
        read -e DIR_INPUT
        echo "Hai scelto la cartella: $DIR_INPUT"
        ls "$DIR_INPUT"
        echo "Va bene? (y = si, * = no)"
        read yn
done

echo "Ora verra' creata la cartella che conterra' la musica"
echo
echo
exiftool "$DIR_INPUT"* > metadata.txt
cat metadata.txt
echo
echo
echo "Tutto ok?"
read yn
if [ "$yn" == "yes" ] || [ "$yn" == "Y" ] || [ "$yn" == "y" ]; then
ARTISTA=$(grep -m 1 Artist metadata.txt)
PREFISSO="Artist                          : "
ARTISTA=$(echo "$ARTISTA" | sed "s/^$PREFISSO//")
ALBUM=$(grep -m 1 Album metadata.txt)
PREFISSO="Album                           : "
ALBUM=$(echo "$ALBUM" | sed "s/^$PREFISSO//")
else
	echo "Qual'e' l'Artista?"
	read ARTISTA
	echo "Qual'e' l'album?"
	read ALBUM
fi
DIR_OUTPUT=$(echo "$DIR_OUTPUT"/"$ARTISTA")
DIR_OUTPUT=$(echo "$DIR_OUTPUT"/"$ALBUM")
echo "$DIR_OUTPUT"



echo
echo


mkdir -p "$DIR_OUTPUT"/ #crea, nel caso la cartella non sia gia' esistente, la directory di destinazione
echo "DIR_OUTPUT" $DIR_OUTPUT >> log_ffpmeg-script.txt #crea un log della cartella appena creata, in caso ci si


for i in "$DIR_INPUT"*.flac; do
	if [ -e "$i" ]; then
   		file=`basename "$i" .flac`
  		"$DIR_FFMPEG" -i  "$i" -c:a "$ENCODER" -b:a "$bitrate"k  "$DIR_OUTPUT"/"$file"."$EXTENSION"
	fi
done

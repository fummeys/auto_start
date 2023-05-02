#!/usr/bin/bash

SCRI="$@"
FILES=(`du -a | cut -d '/' -f2-`)

sumfiles(){
	TMPSUM=""
	for i in "${FILES[@]}"; do
		if [ -f "$i" ]; then
			TMPSUM=$TMPSUM$(md5sum "$i" | cut -d ' ' -f1)
		fi
	done
	echo $TMPSUM
}

SUMFILES1=$(sumfiles)

echo "watching files for changes"

while true; do
	SUMFILES2=$(sumfiles)
	if [[ $SUMFILES1 != $SUMFILES2 ]]; then
		SUMFILES1=$SUMFILES2
		$SCRI
	fi
	sleep 1
done

#!/bin/bash

YEAR_WEEK="$1"

if [[-n "$YEAR_WEEK"]]; then
	OPT="-w $YEAR_WEEK"
    echo "[+] 주차: $YEAR_WEEK 로 실행"
else
	OPT=""
    echo "[+] 주차 없이 실행"
fi

/usr/bin/python3.12 /절대경로/data_etl.py $OPT
sleep 5
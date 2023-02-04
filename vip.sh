#!/bin/sh  
  
num=n  
city=n  
files=0  
NUM=3  
CITY=  
CUSTOMER_FILE=  
AMOUNT_FILE=  
  
while [ $# -gt 0 ]; do  
  case "$1" in  
    -n)  
      num=y  
      ;;  
    -c)  
      city=y  
      ;;  
    *)  
      if [ $num = y ] ; then  
        NUM=$1  
        num=n  
      elif [ $city = y ] ; then  
        CITY=$1  
        city=n  
      elif [ $num = n ] && [ $city = n ] && [ $files -eq 0 ] ; then  
        CUSTOMER_FILE=$1  
        files=$((files+1))  
      else  
        AMOUNT_FILE=$1  
        files=$((files+1))  
      fi  
      ;;  
  esac  
  shift  
done  
  
if [ $files -ne 2  ] ; then  
  echo "ERROR: needs exactly 2 file  arguments CUSTOMER_FILE and AMOUNT_FILE, and only invalid options -n and -c" >&2  
  exit 1  
elif ! [ -e $CUSTOMER_FILE ] || ! [ -e $AMOUNT_FILE ] ; then  
  echo "ERROR: please make sure CUSTOMER_FILE and AMOUNT_FILE exist" >&2  
  exit 2  
fi  
  
if [ -z "$CITY" ] ; then  
  join -t : -j 1 $CUSTOMER_FILE $AMOUNT_FILE | sort -n -r -t: -k 3,3 | grep -m $NUM  "" | cut -d ":" -f 1,3  
else  
  join -t : -j 1 $CUSTOMER_FILE $AMOUNT_FILE | sort -n -r -t: -k 3,3 | grep -m $NUM ":$CITY:" | cut -d ":" -f 1,3  
fi  

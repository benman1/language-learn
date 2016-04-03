#!/bin/bash 
# syntax geline line filename

#echo "Parameter #1 is $1"
#echo "Parameter #2 is $2"

get_line () {
   head -n $1 $2 | tail -n 1
}



get_line  $1 $2

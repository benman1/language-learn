#!/bin/bash

# this script splits a 'facts' file exported from anki
# each line corresponds to a fact
# the fact and its explanation are tab-separated

# get words on the first
#awk '{print $1}' colloquial_greek_facts.txt | sed "s/,//" > left
#awk -F'\t'  '{print $NF}' colloquial_greek_facts.txt | sed "s/\[[^]]*\]//g" >right

f1count=`cat left | wc -l`
f2count=`cat right | wc -l`

# compare line counts
# if not equal abort with error

splitsize=20
setid=1
filen=factset${setid}.mp3 

rm -f factset*.mp3

# silence for padding
sox -n -r 16000 -c 1 silence.wav trim 0.0 1.0
# note that this file should correspond in sampling rate and channels to the other files, otherwise sox will complain
# test sr and channels like this: soxi -r filename; soxi -c filename 

s=0
for i in $(seq 1 $f1count)
do
  tail -n +${i} left | head -n 1 | espeak -s 120 -v mb-gr2 -w l.wav 
  tail -n +${i} right | head -n 1 | espeak -s 150 -v mb-en1 -w r.wav 
  tail -n +${i} left | head -n 1 | espeak -s 160 -v mb-gr2 -w rep.wav 
  sox silence.wav silence.wav l.wav silence.wav silence.wav r.wav silence.wav rep.wav silence.wav silence.wav lr.mp3
  if [ -a $filen ]; then
    #echo mv ${filen} dummy.mp3
    mv ${filen} dummy.mp3
    #echo sox lr.mp3 dummy.mp3 ${filen}
    sox lr.mp3 dummy.mp3 ${filen}
  else
    sox lr.mp3 ${filen}
    #echo sox lr.mp3 ${filen}
  fi

  s=$[s + 1]
  if [[ $s -ge $splitsize ]] ; then
    s=0
    setid=$[setid + 1]
    filen=factset${setid}.mp3 
  fi  
done

rm -f dummy.mp3 lr.mp3 l.wav r.wav rep.wav


#espeak -v mb-gr1 "Hello World" -w file.wav
#echo hello | text2wave -eval "(voice_us1_mbrola)"  -o myfile.wav
#echo Your job has completed | text2wave -eval '(voice_us3_mbrola)' >job.wav

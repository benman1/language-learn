#!/bin/bash 

#el_word_frequency.txt
#Greek_verbs.txt

ln=$(wc -l el_word_frequency.txt | awk '{print $1}')


rm -f most_frequent_verbs.txt

for word in $(cat el_word_frequency.txt | awk '{print $1}')
do
  echo "word: ${word}"

  # in the Greek_verbs.txt list? 
  found=$(grep -i "^${word}," Greek_verbs.txt)
  if [ $? -ne 1 ]
      then # found
      echo "identified as Verb with meaning"
      found=$(echo "$found" | head -n 1)
      echo "${found}" >> most_frequent_verbs.txt
      #echo "${found}" 
  fi
  echo "found: ${found}"
 
done

#head -n 250 most_frequent_verbs.txt | sed -e "s/\(^[^ ,\/]*\).*$/\1/" > most_frequent_verbs500.txt1
#head -n 250 most_frequent_verbs.txt | sed -e "s/.*\([0-9][0-9]*\|vt\|vi\)[\., ]*\(.*\)$/\2/" > most_frequent_verbs500.txt2 
#paste most_frequent_verbs500.txt1 most_frequent_verbs500.txt2 > most_frequent_verbs500.txt

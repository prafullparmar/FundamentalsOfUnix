#!/bin/bash
input="100 CC Records.csv"

while IFS=","  read -r c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 
do
   dat=$(date +%Y%m)
   cmp=${c8:3}${c8:0:2}
   path="CreditCards/"$c2"/"$c3
   mkdir -p "$path"
   if [ $cmp -gt $dat ]
   then
     path=$path"/"$c4".active.txt"
   else
      path=$path"/"$c4".expired.txt"
   fi
     echo "Card Type Code: $c1" > "$path"
     echo "Card Type Full Name: $c2" >> "$path"
     echo "Issuing Bank: $c3" >> "$path"
     echo "Card Number: $c4" >> "$path"
     echo "Card Holder's Name: $c5" >> "$path"
     echo "CVV/CVV2: $c6" >> "$path"
     echo "Issue Date: $c7" >> "$path"
     echo "Expiry Date: $c8" >> "$path"
     echo "Billing Date: $c9" >> "$path"
     echo "Card PIN: $c10" >> "$path"
     c11=${c11//[$'\t\r\n']}
     credit=$(sed -r ':L;s=\b([0-9]+)([0-9]{3})\b=\1,\2=g;t L' <<< "$c11")
     echo "Credit Limit: $"$credit" USD" >> "$path"
done < <( tail -n +2 "$input")

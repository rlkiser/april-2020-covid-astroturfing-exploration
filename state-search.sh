#!/bin/bash
set -euo pipefail

STATESFILE="state-list.txt"
REGISTRATIONS="registration-dates.txt"
DATE=$(date)

declare -a STATES
STATES=(`cat "$STATESFILE"`)

touch $REGISTRATIONS
echo "File created on $DATE" > $REGISTRATIONS

# Write whois records to individual files and write registration dates to dates file.
for (( i = 0 ; i < 100 ; i++))
do
  WHOISREC=$(whois "reopen${STATES[$i]}.com")
  REGISTRATIONDATE=$(echo "$WHOISREC" | grep "Creation Date" | sed 's/^[ \t]*//;s/[ \t]*$//' | uniq)

  echo "$WHOISREC" > whois-records/${STATES[$i]}.txt
  echo "${STATES[$i]}"
  echo "reopen${STATES[$i]}.com $REGISTRATIONDATE" >> $REGISTRATIONS
done

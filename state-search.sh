#!/bin/bash
set -euo pipefail

STATESFILE="state-initials.txt"
REGISTRATIONS="registration-dates.txt"
DATE=$(date)

declare -a STATES
STATES=(`cat "$STATESFILE"`)

touch $REGISTRATIONS
echo "File created on $DATE" > $REGISTRATIONS

# Write whois records to individual files and write registration dates to dates file.
for (( i = 0 ; i < 50 ; i++))
do
  WHOISREC=$(whois "ReOpen${STATES[$i]}.com")
  REGISTRATIONDATE=$(echo "$WHOISREC" | grep "Creation Date" | sed 's/^[ \t]*//;s/[ \t]*$//' | uniq)

  echo "$WHOISREC" > whois-records/${STATES[$i]}.txt
  echo "${STATES[$i]}"
  echo "reopen${STATES[$i]}.com $REGISTRATIONDATE" >> $REGISTRATIONS
done

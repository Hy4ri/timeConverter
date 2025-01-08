#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
RESET='\033[0m'

# Helper function to convert hours and minutes into total minutes
toMinutes() {
    local hours=$1
    local minutes=$2
    echo $((hours * 60 + minutes))
}

# Helper function to convert total minutes back to hours and minutes
fromMinutes() {
    local totalMinutes=$1
    local resultHours=$((totalMinutes / 60))
    local resultMinutes=$((totalMinutes % 60))

    # Handle AM/PM and day rollover
    local period="AM"
    local dayCount=0

    if ((resultHours >= 24)); then
        dayCount=$((resultHours / 24))
        resultHours=$((resultHours % 24))
    fi

    if ((resultHours >= 12)); then
        period="PM"
        if ((resultHours > 12)); then
            resultHours=$((resultHours - 12))
        fi
    fi

    if ((resultHours == 0)); then
        resultHours=12 # Midnight is 12 AM
    fi

    echo "$resultHours:$resultMinutes $period $dayCount day(s) later"
}

# Function to add time
timePlus() {
    echo -e "${CYAN}Enter the starting hours:${RESET} "
    read hours
    echo -e "${RED}Enter the starting minutes:${RESET} "
    read minutes
    echo -e "${CYAN}Enter the hours to add:${RESET} "
    read addHours
    echo -e "${RED}Enter the minutes to add:${RESET} "
    read addMinutes

    # Convert to total minutes and perform addition
    totalMinutes=$(toMinutes "$hours" "$minutes")
    totalAddMinutes=$(toMinutes "$addHours" "$addMinutes")
    resultMinutes=$((totalMinutes + totalAddMinutes))

    # Convert back to readable format
    echo -e "${GREEN}Resulting time:${RESET} $(fromMinutes $resultMinutes)"
}

timeMinus() {
    echo -e "${CYAN}Enter the current time (hours):${RESET} "
    read currentHours
    echo -e "${RED}Enter the current time (minutes):${RESET} "
    read currentMinutes
    echo -e "${CYAN}Enter the target time (hours):${RESET} "
    read targetHours
    echo -e "${RED}Enter the target time (minutes):${RESET} "
    read targetMinutes

    # Convert both times to total minutes
    currentTotalMinutes=$(toMinutes "$currentHours" "$currentMinutes")
    targetTotalMinutes=$(toMinutes "$targetHours" "$targetMinutes")

    # Calculate the difference
    if ((targetTotalMinutes >= currentTotalMinutes)); then
        difference=$((targetTotalMinutes - currentTotalMinutes))
    else
        # If the target time is on the next day
        difference=$((1440 - currentTotalMinutes + targetTotalMinutes)) # 1440 = total minutes in a day
    fi

    # Convert back to hours and minutes
    resultHours=$((difference / 60))
    resultMinutes=$((difference % 60))

    # Display the result
    echo -e "${GREEN}Time remaining:${RESET} $resultHours hours and $resultMinutes minutes"
}

# Main menu
echo -n "Choose mode (1: time+time, 2: time-time): "
read choice

case "$choice" in
    1 | t+a | time+time)
        timePlus
        ;;
    2 | t-t | time-time)
        timeMinus
        ;;
    *)
        echo "Invalid option. Please choose either 1 or 2."
        ;;
esac

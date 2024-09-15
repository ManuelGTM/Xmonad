#!/bin/bash

# Check if Conky is running
if pgrep -x "conky" > /dev/null
then
    pkill conky
else
    conky
fi


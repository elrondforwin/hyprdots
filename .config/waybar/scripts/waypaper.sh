#!/bin/bash

# Launch Waypaper GUI if it's not already running
if ! pgrep -x "waypaper" > /dev/null; then
    waypaper &
fi
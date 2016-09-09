#!/bin/bash

#                               .___                     
#     ___________    _____    __| _/__  ___              
#    /  ___/\__  \  /     \  / __ |\  \/  /              
#    \___ \  / __ \|  Y Y  \/ /_/ | >    <               
#   /____  >(____  /__|_|  /\____ |/__/\_ \              
#        \/      \/      \/      \/      \/              
#   _______________  ____  ________                      
#   \_____  \   _  \/_   |/  _____/                      
#    /  ____/  /_\  \|   /   __  \                       
#   /       \  \_/   \   \  |__\  \                      
#   \_______ \_____  /___|\_____  /                      
#           \/     \/           \/                       

# http://patorjk.com/software/taag/#p=display&f=Graffiti

# Tue 23 Aug 2016 10:48:47 PM ICT
# Wed 24 Aug 2016 02:00:22 AM ICT

# Check if the source dir is provided, cd to that location unless
# the sourcedir is the current-working-dir.

if [ -n "$1" ]; then
    readonly SOURCEDIR="$1"
    echo -e "\tYOU'VE SPECIFIED THE SOURCE DIR IS:\n"
    echo -e "\t$SOURCEDIR"
    echo -e "\CD TO THE WORKDIR"
    cd "$SOURCEDIR"
else
    echo -e "\tYOU'VE NOT SPECIFIED THE SOURCE DIR."
    echo -e "\tTHEN THE SOURCE DIR IS THE CURRENT-WORKING-DIR."
    SOURCEDIR="$(pwd)"
fi

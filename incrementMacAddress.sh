# Created by Samantha Mintzmyer 
# This file intends to increment the address of the user's MAC Address
# at the common active wireless interfaces en0 and awdl0

#!/bin/bash 

echo "Old en0:"
en0=$(ifconfig en0 | awk '/ether/{print $2}')
echo $en0

# Separate 5 base hex numbers from the 6th to be incremented
en0base=$(echo $en0 | cut -b-15)
en0inc=$(echo $en0 | cut -b16-)

# Increment 6 hex (returned in decimal) and convert back to hex
en0dig=$(echo "obase=16;ibase=16;$((0x$en0inc+0x1))" |bc)
en0hex=$(printf "%X\n" $en0dig)

# Update interface ether address
en0new=$en0base$en0hex
sudo ifconfig en0 ether $en0new
echo "New en0:"
en0=$(ifconfig en0 | awk '/ether/{print $2}')
echo $en0


echo "Old awdl0:"
awdl0=$(ifconfig awdl0 | awk '/ether/{print $2}')
echo $awdl0

# Separate 5 base hex numbers from the 6th to be incremented
awdl0base=$(echo $awdl0 | cut -b-15)
awdl0inc=$(echo $awdl0 | cut -b16-)

# Increment 6 hex (returned in decimal) and convert back to hex
awdl0dig=$(echo "obase=16;ibase=16;$((0x$awdl0inc+0x1))" |bc)
awdl0hex=$(printf "%X\n" $awdl0dig)

# Update interface ether address
awdl0new=$awdl0base$awdl0hex
sudo ifconfig awdl0 ether $awdl0new
echo "New awdl0:"
awdl0=$(ifconfig awdl0 | awk '/ether/{print $2}')
echo $awdl0

echo "To customize further, use: ifconfig <en0/awdl0> ether <custom address>"

#!/bin/bash

echo "iMessage Configuration Helper"
echo "-----------------------------"
echo -n "Are you sure to run this script? (y/n): "
read confirm
if ! [ $confirm = "y" ]; then exit; fi
# delete some files
cd ~/Library/Caches/
rm -R com.apple.Messages*
rm -R com.apple.imfoundation*
cd ~/Library/Preferences/
rm -R com.apple.iChat*
rm -R com.apple.imagent*
rm -R com.apple.imessage*
rm -R com.apple.imservice*
rm -R ~/Library/Messages/

echo -n "Do you want to clean network preferences, too? (y/n): "
read confirm
if [ $confirm = "y" ]; then
  # delete network interfaces
  cd /Library/Preferences/SystemConfiguration/
  rm NetworkInterfaces.plist
  rm preferences.plist
fi
echo "Done."
echo "If you have already created the config.plist for your Hackintosh, you can now restart."
exit 0

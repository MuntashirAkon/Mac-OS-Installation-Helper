#!/bin/bash

echo "en0 Configuration Helper"
echo "------------------------"
echo -n "Do you have a working Ethernet/Wifi? (y/n): "
read confirm
if [ $confirm = "y" ]; then
  # delete network interfaces
  cd /Library/Preferences/SystemConfiguration/
  rm NetworkInterfaces.plist
  rm preferences.plist
else
  echo "You have to use Null Ethernet Network. Visit this link for details: http://bit.ly/null-ethernet"
  exit
fi
echo "Done. Restart? (y/n): "
read confirm
if [ $confirm = "y" ]; then
  sudo shutdown -r now "Restarting..."
fi
echo "You choose not to restart now."
exit 0

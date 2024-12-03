#!/bin/bash -e

server_ip=$(ip addr show wt0 2>/dev/null | grep 'inet ' | awk '{print $2}' | cut -d'/' -f1 | xargs)

echo "exec chromium-browser --disable-infobars --display=:0 --incognito --display=:0 http://$server_ip:8000/admin" >> /home/example_user/.config/i3/config
echo "exec i3-sensible-terminal" >> /home/example_user/.config/i3/config
echo "exec i3-msg workspace 1; layout tabbed" >> /home/example_user/.config/i3/config


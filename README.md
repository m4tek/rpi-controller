# rpi-controller
My log of converting an RPI into a automation controller

## Hardware changes

### Connect power via MeanWell DDR-30G-5 DC-DC step-down PSU from 24V battery system powering PLCs
### Connect a LED via 330Ohm resistor between GPIO 27 and GND (convininently next to each other on HW pins 13 and 14)
### Put the Pi in a DIN-mounable case like: https://www.thingiverse.com/thing:2492974

## SW changes 
### Add `dtoverlay=gpio-led,gpio=27,label=heart,trigger=heartbeat` to `/boot/firmware/config.txt` to create `/sys//class/leds/heart/` user contrlled device
### Load `ledtrig-pattern` module to easily control LED patterns
### Add script `/etc/pam.d/sshd` triggered by `open_session` & `close_session` to count active users and if # of users > 0 change `heatbeart` trigger to `pattern` trigger with pattern config of `0 200 1 200` 

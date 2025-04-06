# rpi-controller
My log of converting an RPI into a automation controller

## Hardware changes

### Connect power via MeanWell DDR-30G-5 DC-DC step-down PSU from 24V battery system powering PLCs
### Connect a LED via 330Ohm resistor between GPIO 27 and GND (convininently next to each other on HW pins 13 and 14)
### Put the Pi in a DIN-mounable case like: https://www.thingiverse.com/thing:2492974

## SW changes 
- Add `dtoverlay=gpio-led,gpio=27,label=heart,trigger=heartbeat` to `/boot/firmware/config.txt` to create `/sys/class/leds/heart/` user contrlled device
- Load `ledtrig-pattern` module to easily control LED patterns
- Add execution of the script to `/etc/pam.d/common-session` to be triggered by `open_session` & `close_session` and count active users 
  - If # of users > 0 change `heatbeart` trigger to `pattern` trigger with pattern config of `0 50 1 59` and reverse should there be no action sessions left

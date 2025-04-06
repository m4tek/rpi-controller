#!/bin/bash

reset_led () {
	logger -ie -p local0.info "Setting heartbeat mode"
	echo "heartbeat" >  /sys/class/leds/heart/trigger 
}

activate_session_led () {
	logger -ie -p local0.info "Setting blink mode"
	echo "pattern" >  /sys/class/leds/heart/trigger && \
	  echo "0 50 1 50" >  /sys/class/leds/heart/pattern 
}

active_sessions=$(/usr/bin/who | /usr/bin/wc -l)

if [[ -r /sys/class/leds/heart/trigger ]]; then
  trig=$(/usr/bin/sed 's/.*\[\(.*\)\].*/\1/' /sys/class/leds/heart/trigger)
fi

case "$PAM_TYPE" in
  open_session)
    activate_session_led
    ;;
  *)
    if [ "$active_sessions" -lt 1 ]; then
      reset_led		
    else
      activate_session_led
    fi
esac

if [ "$(ps -o comm= $PPID)" != "systemd" ]; then
  logger -ie -p local0.info "Number of sessions [${active_sessions}] during ${PAM_TYPE}, on ${PAM_TTY} for ${PAM_USER}. Trigger set at $trig"
else
  logger -ie -p local0.info "Number of sessions [${active_sessions}] while checked by systemd timer. Trigger set at $trig"
fi

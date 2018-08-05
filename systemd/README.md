# Pre-Conditions

The unit/timer files must be at: `~/.config/systemd/user` (the script `setup-user-systemd.sh` already did that to you)

# How to enable the timers:

	$ systemctl --user list-timers  # show all configured timers

	$ systemctl --user enable cycle-wallpaper.timer  # enable this timer

	$ # (both commands below must run together for the user systemd to detect this timer)
	$ systemctl --user daemon-reload  # reloads the user daemon to detect the changes
	$ systemctl --user start cycle-wallpaper.timer  # start the timer

	$ systemctl --user list-timers  # show all configured timers - now you should see the new timer 

	$ systemctl --user status cycle-wallpaper.timer  # show the timer status

	$ journalctl --user -f -u cycle-wallpaper -n 50  # this is to see the timer logs interactively 


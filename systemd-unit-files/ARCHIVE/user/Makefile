.PHONY: help status nets

PROJECT_ROOT=$(shell pwd)
SYSTEMD_FILES := hdd-wakeup.service hdd-wakeup.timer

help:  ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

setup:  # setup the systemd folder for the user
	mkdir -p $(HOME)/.config/systemd/user

sync: setup  ## sync the systemd services and timers here to the user's folder
	$(foreach filename, $(SYSTEMD_FILES), \
		rsync -chzPvi --progress $(filename) $(HOME)/.config/systemd/user/$(filename) ; \
	)
	@echo "systemd files successfully copied."

reload:  ## reload the systemd user daemon
	systemctl --user daemon-reload
	systemctl --user start hdd-wakeup.timer
	systemctl --user enable hdd-wakeup.timer

timers-list:  ## list the user timers
	systemctl --user list-timers

journalctl:  ## show the systemd user logs in real-time
	journalctl --user -f

journalctl-hdd-wakeup:  ## show the hdd-wakeup service logs in real-time
	journalctl --user -u hdd-wakeup.service -f

all: sync reload timers-list  ## sync, reload and list the systemd timers
	echo "Successfully finished"


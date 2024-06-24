SHELL = /bin/sh
OPT_DIR = /opt

ifeq ($(PREFIX),)
	PREFIX := /usr/local
endif

help:
	@echo "Use one of the following options:"
	@echo "install - Installs daily-prayers"
	@echo "uninstall - Uninstalls daily-prayers"
	@echo "reinstall - Reinstalls daily-prayers"
	@echo "update - Updates daily-prayers"

crater-get:
	@echo "Setting up Crater for temporary use..."
	git clone https://github.com/crater-space/cli /tmp/crater-cli

primary-deps:
	@echo "Making sure mpv is installed..."
ifneq ($(shell command -v mpv),)
	@echo "mpv found."
else
	@echo "mpv not found!"
	@echo "Attempting to install mpv using Crater..."
	/tmp/crater-cli/crater install mpv
endif
	@echo "Making sure pipewire is installed..."
ifneq ($(shell command -v pipewire),)
	@echo "pipewire found."
else
	@echo "pipewire not found!"
	@echo "Attempting to install pipewire using Crater..."
	/tmp/crater-cli/crater install pipewire
endif
	@echo "Making sure dbus is installed..."
ifneq ($(shell command -v dbus),)
	@echo "dbus found."
else
	@echo "dbus not found!"
	@echo "Attempting to install dbus using Crater..."
	/tmp/crater-cli/crater install dbus
endif
	@echo "All required dependencies found."

crater-remove:
	@echo "Removing Crater..."
	rm -rf /tmp/crater-cli

req: crater-get primary-deps crater-remove

place:
	@echo "Installing commands..."
	sudo install ./scripts/* $(PREFIX)/bin/
	sudo mkdir -p $(OPT_DIR)/daily-prayers/adhans
	sudo cp -R ./adhans/* $(OPT_DIR)/daily-prayers/adhans
	@echo "commands installed."

configure:
	@if test -f "$(OPT_DIR)/daily-prayers/coordinates"; then \
		echo "Configuration exists!"; \
	else \
		echo "Configuring..."; \
		./scripts/daily-prayers-configure; \
	fi

init:
	./scripts/daily-prayers-set-alarms

install: req place configure init
	@echo "daily-prayers is now installed."

uninstall:
	@echo "Uninstalling daily-prayers..."
	sudo rm $(PREFIX)/bin/daily-prayers*
	sudo rm -rf $(OPT_DIR)/daily-prayers
	sudo crontab -u $$USER -r
	@echo "daily-prayers has been uninstalled."

reinstall: uninstall install

get-latest:
	git pull origin main

update: get-latest reinstall

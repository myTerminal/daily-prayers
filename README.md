# daily-prayers

[![License](https://img.shields.io/github/license/myTerminal/daily-prayers.svg)](https://opensource.org/licenses/MIT)  
[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/Y8Y5E5GL7)

An automated prayer call alarm system for UNIX-like systems

> Note: This alpha-quality software is expected to receive heavy updates in the coming weeks, InshaAllah. The implementation works on my test hardware and software, and though support for more setups will come soon, please feel free to contribute to make it more usable.

## Requirements

### Hardware

You can run this software on any hardware that can run Linux or other UNIX-like systems.

### Software

*daily-prayers* should run on almost all UNIX-like operating systems. It also needs the following additional dependencies, all of which it attempts to install during setup:

 - [Node.js](https://nodejs.org)
 - [mpv](https://mpv.io)
 - [PipeWire](https://pipewire.org)
 - [dbus](https://www.freedesktop.org/wiki/Software/dbus)

## Installation

There are a few different ways to get *daily-prayers*.

### Compile from source

    # Clone project to the local workspace
    git clone https://github.com/myTerminal/daily-prayers.git

    # Switch to the project directory
    cd daily-prayers

    # Install with `make`
    make install

### Automatic installation

Simply execute the below command in a terminal; the rest should be automatic.

    /bin/bash -c "$(curl https://raw.githubusercontent.com/myTerminal/daily-prayers/main/install)"

### Through a package manager

*daily-prayers* will soon be available to install from your operating system's package manager.

## How to Use

Once installed, *daily-prayers* works automatically:

1. It fetches the prayer timings for the day once at the start of the day and sets reminders
2. At the prayer times it sets by itself, it plays an audio version of the appropriate Adhan

The following parameters have been hard-coded for the time being and will be made configurable soon:

1. **Prayer time calculation method** has been set to "Islamic Society of North America"
2. **School** has been set to "Hanafi"

**Note:** As *daily-prayers* works with `cron` jobs, it is suggested to be run for a non-organic user dedicated specifically to this.

    useradd muezzin -m
    passwd muezzin
    usermod -aG wheel,audio,video,optical,storage muezzin

Using a dedicated user would make sure it won't conflict with `cron` jobs for other users.

### Configuring for your location (automatic)

    daily-prayers-configure

The above command prompts the user for geographical coordinates for Adhan reminders.

### Setting alarms for the current day (automatic)

    daily-prayers-schedule-tasks

The above command schedules Adhan reminders, and a few other tasks

## Updating

In order to update *daily-prayers*, simply run:

    daily-prayers-update

## Uninstalling

In order to uninstall *daily-prayers*, simply run:

    daily-prayers-uninstall

## To-Do

- Remove dependency on `pipewire` and `dbus`
- Implement an Adhan dashboard
- Allow configuration beyond the location

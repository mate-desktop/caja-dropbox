#!/usr/bin/bash

set -eo pipefail

# Use grouped output messages
infobegin() {
	echo "::group::${1}"
}
infoend() {
	echo "::endgroup::"
}

# Required packages on Ubuntu
requires=(
	ccache # Use ccache to speed up build
)

# https://git.launchpad.net/ubuntu/+source/caja-dropbox/tree/debian/control
requires+=(
	autoconf-archive
	autopoint
	gcc
	gettext
	git
	libcaja-extension-dev
	libglib2.0-dev
	make
	mate-common
	python3-docutils
	python3-gi
)

infobegin "Update system"
apt-get update -y
infoend

infobegin "Install dependency packages"
env DEBIAN_FRONTEND=noninteractive \
	apt-get install --assume-yes \
	${requires[@]}
infoend

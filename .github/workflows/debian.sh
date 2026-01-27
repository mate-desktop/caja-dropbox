#!/usr/bin/bash

# Use grouped output messages
infobegin() {
	echo "::group::${1}"
}
infoend() {
	echo "::endgroup::"
}

# Required packages on Debian
requires=(
	ccache # Use ccache to speed up build
)

# https://salsa.debian.org/debian-mate-team/caja-dropbox
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
apt-get update -qq
infoend

infobegin "Install dependency packages"
env DEBIAN_FRONTEND=noninteractive \
	apt-get install --assume-yes \
	${requires[@]}
infoend

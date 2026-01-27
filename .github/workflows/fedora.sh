#!/usr/bin/bash

# Use grouped output messages
infobegin() {
	echo "::group::${1}"
}
infoend() {
	echo "::endgroup::"
}

# Required packages on Fedora
requires=(
	ccache # Use ccache to speed up build
)

# https://src.fedoraproject.org/cgit/rpms/caja-dropbox.git
requires+=(
	autoconf-archive
	caja-devel
	gcc
	git
	make
	mate-common
	python3-docutils
	python3-gobject
	redhat-rpm-config
)

infobegin "Update system"
dnf update -y
infoend

infobegin "Install dependency packages"
dnf install -y ${requires[@]}
infoend

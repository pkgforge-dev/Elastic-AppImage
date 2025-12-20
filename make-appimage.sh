#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q elastic | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/app.drey.Elastic.svg
export DESKTOP=/usr/share/applications/app.drey.Elastic.desktop
export STARTUPWMCLASS=app.drey.Elastic # Default to Wayland's wmclass. For X11, GTK_CLASS_FIX will force the wmclass to be the Wayland one.
export GTK_CLASS_FIX=1

# Trace and deploy all files and directories needed for the application (including binaries, libraries and others)
quick-sharun /usr/bin/elastic

# Turn AppDir into AppImage
quick-sharun --make-appimage

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
export DEPLOY_OPENGL=1
export STARTUPWMCLASS=elastic
export GTK_CLASS_FIX=1

# Trace and deploy all files and directories needed for the application (including binaries, libraries and others)
quick-sharun /usr/bin/elastic

# Turn AppDir into AppImage
quick-sharun --make-appimage

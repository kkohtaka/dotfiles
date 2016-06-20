#!/bin/bash
# Copyright (C) 2016 Kazumasa Kohtaka <kkohtaka@gmail.com> All right reserved

DIR=$HOME/dotfiles
BACKUP_DIR="$DIR.bak"

# Define generic functions

check_existence_of() {
    type "$1" > /dev/null 2>&1
}

pushd $DIR

# Fetch external modules

git submodule update --init

# List dotfiles

FILES=$(find . -maxdepth 1 -name "_*" | xargs -I {} basename {})

# Create a directory to backup

mkdir -p "$BACKUP_DIR"

# Create symbolic links to dotfiles

for FILE in $FILES; do
    BASE_NAME=$(echo "$FILE" | sed -E "s/_//")
    DST=$HOME/.$BASE_NAME
    if [ -e "$DST" ]; then
        if [ -L "$DST" ]; then
            echo "Removing an old symlink..."
            rm "$DST"
        else
            echo "Backing up .$BASE_NAME..."
            mv "$DST" "$BACKUP_DIR/"
        fi
    fi
    ln -sf "$DIR/$FILE" "$HOME/.$BASE_NAME"
done

popd

. $HOME/.bash_profile

# Install APT packages

APT_PACKAGES="$(cat apt_packages.txt)"
for APT_PACKAGE in $APT_PACKAGES; do
    sudo apt-get install "$APT_PACKAGE" -y
done

# Install Go packages

GO_PACKAGES="$(cat go_packages.txt)"
for GO_PACKAGE in $GO_PACKAGES; do
    go get "$GO_PACKAGE"
done

# Install packages for Atom

ATOM_PACKAGES="$(cat atom_packages.txt)"
for ATOM_PACKAGES in $ATOM_PACKAGES; do
    apm install "$ATOM_PACKAGES"
done

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

FILES=$(find . -depth 1 -name "_*" | xargs basename)

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

# Install Homebrew

if check_existence_of "brew"; then
    echo "Homebrew is already installed"
else
    echo "Installing Homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if ! check_existence_of "brew"; then
    echo "Failed to install Homebrew"
    exit -1
fi

# Update Homebrew

echo "Updating Homebrew..."
brew update && brew upgrade

# Install packages via Homebrew

BREW_PACKAGES="$(cat brew_packages.txt)"
for BREW_PACKAGE in $BREW_PACKAGES; do
    brew install "$BREW_PACKAGE"
done

# Install applications via Homebrew Cask

APPLICATIONS="$(cat applications.txt)"
for APPLICATION in $APPLICATIONS; do
    brew cask install "$APPLICATION"
done

# Install Go packages

. $HOME/.bash_profile

GO_PACKAGES="$(cat go_packages.txt)"
for GO_PACKAGE in $GO_PACKAGES; do
    go get "$GO_PACKAGE"
done

# Install packages for Atom

ATOM_PACKAGES="$(cat atom_packages.txt)"
for ATOM_PACKAGES in $ATOM_PACKAGES; do
    apm install "$ATOM_PACKAGES"
done

# Install packages for Node.js
# NOTE: These packages requires NVM
NODE_VERSION="v4.4.4"
nvm install "$NODE_VERSION"
nvm use --delete-prefix "$NODE_VERSION"
NPM_PACKAGES="$(cat npm_packages.txt)"
for NPM_PACKAGE in $NPM_PACKAGES; do
    npm install -g "$NPM_PACKAGE"
done


#!/bin/bash

DIR=$HOME/dotfiles
BACKUP_DIR="$DIR.bak"

pushd $DIR

# Fetch external modules

git submodule update --init

# List dotfiles

FILES=$(find . -depth 1 -name '_*' | xargs basename)

# Create a directory to backup

mkdir -p "$BACKUP_DIR"

# Create symbolic links to dotfiles

for FILE in $FILES; do
  BASE_NAME=$(echo "$FILE" | sed -E "s/_//")
  cp "$HOME/.$BASE_NAME" "$BACKUP_DIR/"
  ln -sf "$DIR/$FILE" "$HOME/.$BASE_NAME"
done

popd


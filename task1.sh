#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <input_directory> <output_directory>"
    exit 1
fi

source_dir="$1"
target_dir="$2"

if [ ! -d "$source_dir" ]; then
    echo "Source directory '$source_dir' does not exist"
    exit 1
fi

if [ ! -d "$target_dir" ]; then
    mkdir -p "$target_dir"
fi

files=$(find "$source_dir" -type f)

for file in $files; do
    filename=$(basename "$file")
    if [ -f "$target_dir/$filename" ]; then
        new_filename="$filename.$(date +%s%N | sha256sum | base64 | head -c 8 ; echo)"
        cp "$file" "$target_dir/$new_filename"
    else
        cp "$file" "$target_dir/$filename"
    fi
done

echo "Coping Done! :)"



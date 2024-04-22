#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_directory> <target_directory>"
    exit 1
fi
awdyufgvadshjbvasdfv
source_dir="$1"
target_dir="$2"

if [ ! -d "$source_dir" ]; then
    echo "Source directory '$source_dir' does not exist"
    exit 1
fi

if [ ! -d "$target_dir" ]; then
    mkdir -p "$target_dir"
fi

while IFS= read -r -d '' file; do
    file_hash=$(shasum -a 256 "$file" | cut -d ' ' -f1)
    filename=$(basename "$file")
    if [ -f "$target_dir/$filename" ]; then
        new_filename="$filename.$(date +%s%N | shasum -a 256 | base64 | head -c 8 ; echo)"
        cp "$file" "$target_dir/$new_filename"
    else
        cp "$file" "$target_dir/$filename"
    fi
done < <(find "$source_dir" -type f -print0)

echo "Copying Done! :)"

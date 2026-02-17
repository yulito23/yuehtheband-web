#!/usr/bin/env bash

# ==========================================
# Resize all JPG images in a directory
# - Recursive
# - Keeps aspect ratio
# - Extends to exact size (no crop)
# - Optimized for web
# ==========================================

# ---- Configuration ----
INPUT_DIR="${1:-.}"              # First argument or current directory
OUTPUT_DIR="${2:-resized}"       # Second argument or "resized"
WIDTH=1600                        # Target width
HEIGHT=900                       # Target height
BACKGROUND="#f4f4f4"               # Padding color
QUALITY=100                       # JPEG quality (0-100)
# ------------------------

echo "Input directory:  $INPUT_DIR"
echo "Output directory: $OUTPUT_DIR"
echo "Target size:      ${WIDTH}x${HEIGHT}"
echo "Background:       $BACKGROUND"
echo

mkdir -p "$OUTPUT_DIR"

find "$INPUT_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" \) | while read -r file; do
    # Preserve folder structure
    relative_path="${file#$INPUT_DIR/}" 
    ouput_file=$(basename ${file})
    output_path="$OUTPUT_DIR/$ouput_file"

    mkdir -p "$(dirname "$output_path")"

    echo "Processing: $file into $output_path"

    convert "$file" \
        -resize "${WIDTH}x${HEIGHT}" \
        -background "$BACKGROUND" \
        -gravity center \
        -extent "${WIDTH}x${HEIGHT}" \
        -quality "$QUALITY" \
        -strip \
        "$output_path"
done

echo
echo "Done."

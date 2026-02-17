#!/bin/bash

INPUT="$1"
WIDTH="$2"
HEIGHT="$3"
OUTPUT="$4"

if [ -z "$INPUT" ] || [ -z "$WIDTH" ] || [ -z "$HEIGHT" ] || [ -z "$OUTPUT" ]; then
  echo "Usage: $0 input.jpg width height output.jpg"
  exit 1
fi

convert "$INPUT" \
  -filter Lanczos \
  -resize ${WIDTH}x${HEIGHT}! \
  -unsharp 0x0.75+0.75+0.008 \
  -quality 95 \
  "$OUTPUT"

echo "Created: $OUTPUT"

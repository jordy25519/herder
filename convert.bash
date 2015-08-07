#!/bin/bash
# Convert SVGs to PDFs.
echo "Converting SVGs..."
for i in *.svg; do
  filename=$(basename "$i")
  filename="${filename%.*}"
  echo "${filename}"
  inkscape -A "$filename.pdf" "$filename.svg"
done

# Mergre PDFs.
echo "Merging PDFs..."
pdfunite *.pdf out.pdf

#!/bin/bash
# Automated setup for EmulatorJS and its cores

set -e

echo "=== EmulatorJS Automated Setup ==="

# Step 1: Install dependencies
echo "[1/4] Installing dependencies..."
npm install

# Step 2: Build EmulatorJS main code
echo "[2/4] Building EmulatorJS main code..."
node build.js --npm=emulatorjs

# Step 3: Build all EmulatorJS cores
echo "[3/4] Building all EmulatorJS cores..."
node build.js --npm=cores

# Step 4: Download minified/production files and cores from CDN if missing
DATA_DIR="data"
MIN_ZIP_URL="https://cdn.emulatorjs.org/latest/data/emulator.min.zip"
CORES_ZIP_URL="https://cdn.emulatorjs.org/latest/data/cores.min.zip"

download_and_extract() {
  FILE_URL=$1
  DEST_DIR=$2
  ZIP_NAME=$(basename $FILE_URL)
  if [ ! -f "$DEST_DIR/$ZIP_NAME" ]; then
    echo "Downloading $ZIP_NAME from $FILE_URL..."
    curl -L -o "$DEST_DIR/$ZIP_NAME" "$FILE_URL"
    echo "Extracting $ZIP_NAME..."
    unzip -o "$DEST_DIR/$ZIP_NAME" -d "$DEST_DIR"
    rm "$DEST_DIR/$ZIP_NAME"
  else
    echo "$ZIP_NAME already exists in $DEST_DIR, skipping download."
  fi
}

# Download and extract minified emulator files
echo "[4/4] Checking for minified emulator files from CDN..."
mkdir -p "$DATA_DIR"
download_and_extract "$MIN_ZIP_URL" "$DATA_DIR"
download_and_extract "$CORES_ZIP_URL" "$DATA_DIR"

echo "=== Setup Complete! ==="
echo "You are now ready to use EmulatorJS with all cores and minified production files."
echo "To launch your frontend, open public/index.html or start your dev server."

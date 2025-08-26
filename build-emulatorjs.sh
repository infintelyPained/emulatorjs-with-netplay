#!/bin/bash
# Build EmulatorJS core and all supported cores

set -e

echo "Installing dependencies..."
npm install

echo "Building EmulatorJS main code..."
node build.js --npm=emulatorjs

echo "Building all EmulatorJS cores..."
node build.js --npm=cores

echo "Build complete!"
echo "If you need minified/production-ready files, see:"
echo "  https://github.com/EmulatorJS/EmulatorJS/releases"
echo "  https://cdn.emulatorjs.org/latest/data/emulator.min.zip"
echo "and extract to your data/ directory if needed."

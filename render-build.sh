#!/bin/bash

# Build script for Render deployment

# Install dependencies
echo "Installing dependencies..."
npm install
cd client && npm install && cd ..
cd server && npm install && cd ..

# Build client
echo "Building client..."
cd client && npm run build && cd ..

# Create a directory for serving static files from Express
echo "Setting up for serving static files..."
mkdir -p server/public
cp -r client/build/* server/public/

echo "Build completed successfully!" 
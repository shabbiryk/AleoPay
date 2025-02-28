#!/bin/bash

# AleoPay Deployment Script
echo "Starting AleoPay deployment process..."

# Check if the environment parameter is passed
if [ "$1" != "production" ] && [ "$1" != "development" ]; then
  echo "Usage: ./deploy.sh [production|development]"
  exit 1
fi

ENV=$1
echo "Deploying to $ENV environment"

# Install root dependencies
echo "Installing root dependencies..."
npm install

# Build and deploy contracts if needed
echo "Building Aleo contracts..."
cd Contracts/invoice
snarkvm build
cd ../..

# Setup client
echo "Setting up client..."
cd client
npm install
echo "Building client application..."
npm run build
cd ..

# Setup and start server
echo "Setting up server..."
cd server
npm install

if [ "$ENV" == "production" ]; then
  echo "Starting server in production mode..."
  # You might want to use PM2 or another process manager in production
  # pm2 start index.js --name aleopay
  NODE_ENV=production nohup node index.js > server.log 2>&1 &
else
  echo "Starting server in development mode..."
  npm run dev
fi

cd ..

echo "Deployment complete!"
echo "Client is built and server is running."
if [ "$ENV" == "production" ]; then
  echo "Use a web server like Nginx to serve the static files from the client/build directory."
  echo "The API server is running in the background. Check server/server.log for logs."
else
  echo "Development server is running. Access the application at http://localhost:3000"
fi 
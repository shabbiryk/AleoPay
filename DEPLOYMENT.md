# AleoPay Deployment Guide

This document provides comprehensive instructions for deploying the AleoPay application in various environments.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Local Development Setup](#local-development-setup)
- [Building the Aleo Contract](#building-the-aleo-contract)
- [Deployment Options](#deployment-options)
  - [Option 1: Manual Deployment](#option-1-manual-deployment)
  - [Option 2: Using Docker](#option-2-using-docker)
  - [Option 3: Using the Deployment Script](#option-3-using-the-deployment-script)
  - [Option 4: Cloud Platform Deployment](#option-4-cloud-platform-deployment)
- [Environment Variables](#environment-variables)
- [Database Setup](#database-setup)
- [SSL Configuration](#ssl-configuration)
- [Troubleshooting](#troubleshooting)

## Prerequisites

Before deploying AleoPay, ensure you have the following:

- Node.js (v16+ recommended)
- MongoDB (local or cloud instance)
- Leo/Aleo development tools (for contract deployment)
- Docker and Docker Compose (optional, for containerized deployment)
- Web server (Nginx or similar, for production)
- Domain name (for production)

## Local Development Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/AleoPay.git
   cd AleoPay
   ```

2. **Install dependencies:**
   ```bash
   npm run install:all
   ```

3. **Configure environment variables:**
   ```bash
   cp server/.env.example server/.env
   # Edit server/.env with your configuration
   ```

4. **Start development servers:**
   ```bash
   npm run dev
   ```

## Building the Aleo Contract

The Aleo smart contract provides digital identity management for the AleoPay system.

1. **Navigate to contract directory:**
   ```bash
   cd Contracts/invoice
   ```

2. **Build the contract:**
   ```bash
   snarkvm build
   ```

3. **Deploy to Aleo testnet (if needed):**
   Follow the Aleo Network deployment guidelines based on the latest version of snarkOS.

## Deployment Options

### Option 1: Manual Deployment

#### Backend Deployment

1. **Prepare the server:**
   - Set up a server with Node.js installed
   - Install MongoDB or configure access to a MongoDB instance

2. **Clone and configure:**
   ```bash
   git clone https://github.com/yourusername/AleoPay.git
   cd AleoPay
   npm install
   cd server
   npm install
   cp .env.example .env
   # Edit .env with production values
   ```

3. **Start the server:**
   ```bash
   # Option A: Direct start
   npm start
   
   # Option B: Using PM2 (recommended for production)
   npm install -g pm2
   pm2 start index.js --name aleopay
   pm2 save
   ```

#### Frontend Deployment

1. **Build the React app:**
   ```bash
   cd client
   npm install
   npm run build
   ```

2. **Configure web server:**
   - Copy the Nginx configuration from `nginx.conf`
   - Modify domains and paths as needed
   - Enable the configuration in your web server

3. **Copy build files to web server:**
   ```bash
   # Example with Nginx
   cp -r build/* /var/www/aleopay/client/build/
   ```

### Option 2: Using Docker

1. **Build and start with Docker Compose:**
   ```bash
   # Make sure to configure server/.env first
   cp server/.env.example server/.env
   # Edit server/.env with production values
   
   # Start containers
   docker-compose up -d
   ```

2. **Configure Nginx as a reverse proxy:**
   - Use the provided `nginx.conf` as a template
   - Point it to your Docker container on port 5000

### Option 3: Using the Deployment Script

1. **Make the script executable:**
   ```bash
   chmod +x deploy.sh
   ```

2. **Run the deployment script:**
   ```bash
   # For development
   ./deploy.sh development
   
   # For production
   ./deploy.sh production
   ```

3. **Configure web server:**
   For production, configure Nginx or another web server to serve the static files from `client/build`.

### Option 4: Cloud Platform Deployment

#### Render

1. Create a new Web Service in Render
2. Connect your GitHub repository
3. Set build command: `npm run install:all && npm run build`
4. Set start command: `cd server && node index.js`
5. Add environment variables from `.env.example`

#### Heroku

1. Create a new app in Heroku
2. Connect your GitHub repository
3. Set buildpack to Node.js
4. Add MongoDB add-on or configure external MongoDB
5. Define environment variables in Heroku settings
6. Deploy from the GitHub repository

#### AWS/DigitalOcean/Linode

1. Set up a VPS with Node.js and MongoDB
2. Clone the repository and follow the manual deployment steps
3. Configure Nginx and secure with SSL

## Environment Variables

The following environment variables should be configured in `server/.env`:

| Variable | Description | Example |
|----------|-------------|---------|
| PORT | Server port | 5000 |
| MONGODB_URI | Connection string for MongoDB | mongodb://localhost:27017/aleopay |
| JWT_SECRET | Secret for JWT authentication | your_secret_key |
| ALEO_PRIVATE_KEY | Private key for Aleo operations | your_aleo_private_key |

## Database Setup

### Local MongoDB

```bash
# Start MongoDB locally
mongod --dbpath /path/to/data

# Create database
mongo
> use aleopay
```

### MongoDB Atlas

1. Create a cluster in MongoDB Atlas
2. Create a database user
3. Get the connection string and update your `.env` file
4. Whitelist your server's IP address

## SSL Configuration

For production, secure your application with SSL:

```bash
# Install Certbot for Let's Encrypt
sudo apt-get install certbot python3-certbot-nginx

# Get SSL certificate
sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com

# Certbot will modify your Nginx configuration automatically
```

## Troubleshooting

### Common Issues

1. **MongoDB connection errors:**
   - Check if MongoDB is running
   - Verify connection string in `.env`
   - Check network access and firewall settings

2. **Missing environment variables:**
   - Ensure all required variables are set in `.env`
   - For Docker, check if the volume is correctly mounted

3. **Aleo contract issues:**
   - Verify contract builds successfully
   - Check logs for deployment errors

4. **Web server configuration:**
   - Test Nginx configuration: `nginx -t`
   - Check permission on static files
   - Verify paths in the configuration file

### Logs

- **Server logs:** 
  - PM2: `pm2 logs aleopay`
  - Docker: `docker-compose logs app`
  - Background process: `cat server/server.log`

- **Nginx logs:**
  - Access: `/var/log/nginx/access.log`
  - Error: `/var/log/nginx/error.log`

For additional help, refer to the project documentation or open an issue on GitHub. 
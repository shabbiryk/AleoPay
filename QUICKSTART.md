# AleoPay Quick Deployment Guide

This guide provides quick steps to get AleoPay up and running on popular hosting platforms.

## Deploy to Render

Render offers a simple way to deploy full-stack applications.

### 1. Prepare your repository

Make sure your repository is pushed to GitHub with all the files we've created:
- package.json (root, client, server)
- Docker related files
- .env.example files (don't commit actual .env files)

### 2. Create a new Web Service on Render

1. Sign up or login to [Render](https://render.com/)
2. Click "New +" and select "Web Service"
3. Connect your GitHub repository
4. Configure the service:
   - Name: `aleopay`
   - Environment: `Node`
   - Build Command: `npm run install:all && npm run build`
   - Start Command: `cd server && node index.js`

### 3. Set environment variables

Add all environment variables from `server/.env.example`:
- `PORT`: Use `$PORT` (Render will provide this)
- `MONGODB_URI`: Connection string to your MongoDB database (you can use MongoDB Atlas)
- `JWT_SECRET`: A secure random string
- `ALEO_PRIVATE_KEY`: Your Aleo private key

### 4. Deploy

Click "Create Web Service" and Render will deploy your application.

## Deploy to Vercel (Frontend) + MongoDB Atlas + Render (Backend)

This approach separates frontend and backend deployment.

### 1. Set up MongoDB Atlas

1. Create a [MongoDB Atlas](https://www.mongodb.com/cloud/atlas) account
2. Create a new cluster
3. Set up a database user and get your connection string
4. Whitelist all IP addresses (`0.0.0.0/0`) or specific IPs

### 2. Deploy Frontend to Vercel

1. Sign up or login to [Vercel](https://vercel.com/)
2. Import your GitHub repository
3. Configure the project:
   - Framework Preset: `Create React App`
   - Root Directory: `client`
   - Build Command: `npm run build`
   - Output Directory: `build`
4. Add environment variables:
   - `REACT_APP_API_URL`: URL of your backend API

5. Click "Deploy"

### 3. Deploy Backend to Render

1. Follow steps 1-2 from the Render deployment guide above
2. Change configuration:
   - Root Directory: `server`
   - Build Command: `npm install`
   - Start Command: `node index.js`
3. Set environment variables as described above
4. Click "Create Web Service"

### 4. Update CORS settings

In your server's code, update the CORS configuration to allow requests from your Vercel domain:

```javascript
app.use(cors({
  origin: process.env.NODE_ENV === 'production' 
    ? 'https://your-frontend-domain.vercel.app' 
    : 'http://localhost:3000'
}));
```

## Deploy using Docker to DigitalOcean

### 1. Create a Droplet

1. Sign up or login to [DigitalOcean](https://www.digitalocean.com/)
2. Create a Droplet with Docker pre-installed
3. Connect to your Droplet via SSH

### 2. Deploy the application

1. Clone your repository:
   ```bash
   git clone https://github.com/yourusername/AleoPay.git
   cd AleoPay
   ```

2. Configure environment variables:
   ```bash
   cp server/.env.example server/.env
   nano server/.env  # Edit with your values
   ```

3. Build and start the containers:
   ```bash
   docker-compose up -d
   ```

4. Set up Nginx as a reverse proxy:
   ```bash
   sudo apt-get update
   sudo apt-get install nginx
   sudo cp nginx.conf /etc/nginx/sites-available/aleopay
   sudo ln -s /etc/nginx/sites-available/aleopay /etc/nginx/sites-enabled/
   sudo nginx -t  # Test configuration
   sudo systemctl restart nginx
   ```

5. Set up SSL with Certbot:
   ```bash
   sudo apt-get install certbot python3-certbot-nginx
   sudo certbot --nginx -d yourdomain.com
   ```

## Making Updates

To update your deployed application:

1. Push changes to your GitHub repository
2. If using GitHub integration (Render/Vercel), the updates will deploy automatically
3. If using Docker deployment, pull changes and rebuild:
   ```bash
   git pull
   docker-compose down
   docker-compose up -d --build
   ```

## Troubleshooting

- **Connection issues**: Ensure your MongoDB connection string is correct and the database is accessible
- **Build failures**: Check build logs for errors
- **Runtime errors**: Check application logs (see DEPLOYMENT.md)
- **CORS errors**: Verify that the frontend origin is correctly configured in the backend

For detailed deployment instructions and troubleshooting, see [DEPLOYMENT.md](DEPLOYMENT.md). 
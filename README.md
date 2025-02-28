# AleoPay

AleoPay is an invoice and payment system built on the Aleo blockchain, combining privacy-preserving zero-knowledge proofs with a modern web interface.

## Project Overview

This project consists of three main components:
- **Aleo Smart Contract**: For managing user digital identities and invoice payments
- **Backend Server**: Node.js server with MongoDB for data persistence
- **Frontend Client**: React application for the user interface

## Prerequisites

- Node.js (v16+ recommended)
- MongoDB
- Leo/Aleo development tools (for contract deployment)
- Git

## Setup and Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/AleoPay.git
cd AleoPay
```

2. Install dependencies for all components:
```bash
npm run install:all
```

## Building the Aleo Contract

1. Navigate to the contract directory:
```bash
cd Contracts/invoice
```

2. Build the contract:
```bash
snarkvm build
```

3. (Optional) Deploy the contract to Aleo testnet:
```bash
# Follow specific Aleo deployment instructions
```

## Running the Application Locally

1. Start the development servers:
```bash
npm run dev
```

This will start both the backend server (port 5000) and the frontend client (port 3000) concurrently.

## Deployment

### Backend Deployment

1. Set up your MongoDB in production (Atlas or self-hosted)
2. Update the .env file in the server directory with production values:
```
MONGODB_URI=your_production_mongodb_uri
PORT=5000
```

3. Deploy the server:
```bash
cd server
npm install
npm start
```

### Frontend Deployment

1. Build the production frontend:
```bash
cd client
npm install
npm run build
```

2. Serve the static files using a web server like Nginx or deploy to a platform like Vercel, Netlify, or AWS S3.

### All-in-One Deployment

For platforms like Heroku, Railway, or Render that can serve both frontend and backend:

```bash
npm run deploy
```

## Technologies Used

- **Frontend**: React, React Router
- **Backend**: Node.js, Express, MongoDB
- **Blockchain**: Aleo/Leo
- **Authentication**: JWT (JSON Web Tokens)

## Project Structure

```
AleoPay/
├── client/               # React frontend
├── server/               # Node.js backend
├── Contracts/            # Aleo smart contracts
└── README.md             # This file
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

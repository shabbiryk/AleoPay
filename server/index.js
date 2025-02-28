const express = require('express');
// const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 5001;

// Middleware
app.use(cors());
app.use(express.json());

// Mock database for demo
const mockDB = {
  users: []
};

// Import routes
const userRoutes = require('./routes/users');
const aleoRoutes = require('./routes/aleo');

// Use routes
app.use('/api/users', userRoutes);
app.use('/api/aleo', aleoRoutes);

// Basic route
app.get('/', (req, res) => {
  res.send('Invoice API is running');
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
}); 
const express = require('express');
const router = express.Router();

// Mock database
const users = [
  {
    address: "aleo1abcdef",
    digitalIds: {
      lensId: "lens-user-1",
      twitter: "twitter-user-1",
      telegram: "telegram-user-1",
      gitcoinPassportId: "gitcoin-1",
      zkcat: "zkcat-1"
    }
  }
];

// Get all users
router.get('/', async (req, res) => {
  try {
    res.json(users);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Get one user by address
router.get('/:address', async (req, res) => {
  try {
    const user = users.find(u => u.address === req.params.address);
    if (!user) return res.status(404).json({ message: 'User not found' });
    res.json(user);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Create user
router.post('/', async (req, res) => {
  const user = {
    address: req.body.address,
    digitalIds: req.body.digitalIds || {}
  };

  try {
    users.push(user);
    res.status(201).json(user);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// Update user
router.patch('/:address', async (req, res) => {
  try {
    const userIndex = users.findIndex(u => u.address === req.params.address);
    if (userIndex === -1) return res.status(404).json({ message: 'User not found' });
    
    if (req.body.digitalIds) {
      users[userIndex].digitalIds = {
        ...users[userIndex].digitalIds,
        ...req.body.digitalIds
      };
    }
    
    res.json(users[userIndex]);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

module.exports = router; 
const express = require('express');
const router = express.Router();
const User = require('../models/User');

// Get all users
router.get('/', async (req, res) => {
  try {
    const users = await User.find();
    res.json(users);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Get one user by address
router.get('/:address', async (req, res) => {
  try {
    const user = await User.findOne({ address: req.params.address });
    if (!user) return res.status(404).json({ message: 'User not found' });
    res.json(user);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Create user
router.post('/', async (req, res) => {
  const user = new User({
    address: req.body.address,
    digitalIds: req.body.digitalIds
  });

  try {
    const newUser = await user.save();
    res.status(201).json(newUser);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// Update user
router.patch('/:address', async (req, res) => {
  try {
    const user = await User.findOne({ address: req.params.address });
    if (!user) return res.status(404).json({ message: 'User not found' });
    
    if (req.body.digitalIds) {
      user.digitalIds = req.body.digitalIds;
    }
    
    const updatedUser = await user.save();
    res.json(updatedUser);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

module.exports = router; 
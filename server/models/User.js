const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  address: {
    type: String,
    required: true,
    unique: true
  },
  digitalIds: {
    lensId: String,
    twitter: String,
    telegram: String,
    gitcoinPassportId: String,
    zkcat: String
  },
  createdAt: {
    type: Date,
    default: Date.now
  }
});

module.exports = mongoose.model('User', userSchema); 
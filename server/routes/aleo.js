const express = require('express');
const router = express.Router();

// Initialize a mock Aleo client for now
// In production, you would use the actual Aleo SDK
const mockAleoClient = {
  getProgramObject: async (programId) => {
    return {
      id: programId,
      name: "invoice.aleo",
      functions: [
        "add_digital_ids",
        "update_digital_ids",
        "get_digital_ids_hash"
      ],
      mappings: [
        "key_to_userID"
      ]
    };
  }
};

// Execute add_digital_ids function
router.post('/add-digital-ids', async (req, res) => {
  try {
    // This is a simplified example - in a real app, you'd need to handle 
    // private key securely and sign transactions properly
    res.json({ 
      message: 'To execute this function, the user needs to interact with Aleo directly through the frontend',
      details: 'The frontend should use Aleo SDK to execute the contract function'
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Get program information
router.get('/program-info', async (req, res) => {
  try {
    const programId = process.env.ALEO_PROGRAM_ID || 'invoice.aleo';
    const program = await mockAleoClient.getProgramObject(programId);
    res.json(program);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router; 
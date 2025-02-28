import React, { useState } from 'react';
import axios from 'axios';

const Profile = () => {
  const [address, setAddress] = useState('');
  const [digitalIds, setDigitalIds] = useState({
    lensId: '',
    twitter: '',
    telegram: '',
    gitcoinPassportId: '',
    zkcat: ''
  });
  const [message, setMessage] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post('http://localhost:5000/api/users', {
        address,
        digitalIds
      });
      setMessage('Profile created successfully!');
      console.log('Response:', response.data);
    } catch (error) {
      setMessage('Error creating profile: ' + error.response?.data?.message || error.message);
      console.error('Error:', error);
    }
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    if (name === 'address') {
      setAddress(value);
    } else {
      setDigitalIds({
        ...digitalIds,
        [name]: value
      });
    }
  };

  return (
    <div className="profile-container">
      <h1>Create Your Profile</h1>
      {message && <div className="message">{message}</div>}
      <form onSubmit={handleSubmit}>
        <div className="form-group">
          <label>Address:</label>
          <input
            type="text"
            name="address"
            value={address}
            onChange={handleChange}
            required
          />
        </div>
        <div className="form-group">
          <label>Lens ID:</label>
          <input
            type="text"
            name="lensId"
            value={digitalIds.lensId}
            onChange={handleChange}
          />
        </div>
        <div className="form-group">
          <label>Twitter:</label>
          <input
            type="text"
            name="twitter"
            value={digitalIds.twitter}
            onChange={handleChange}
          />
        </div>
        <div className="form-group">
          <label>Telegram:</label>
          <input
            type="text"
            name="telegram"
            value={digitalIds.telegram}
            onChange={handleChange}
          />
        </div>
        <div className="form-group">
          <label>Gitcoin Passport ID:</label>
          <input
            type="text"
            name="gitcoinPassportId"
            value={digitalIds.gitcoinPassportId}
            onChange={handleChange}
          />
        </div>
        <div className="form-group">
          <label>ZKcat:</label>
          <input
            type="text"
            name="zkcat"
            value={digitalIds.zkcat}
            onChange={handleChange}
          />
        </div>
        <button type="submit" className="btn btn-primary">Create Profile</button>
      </form>
    </div>
  );
};

export default Profile; 
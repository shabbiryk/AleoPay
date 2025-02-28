import React, { useState, useEffect } from 'react';
import axios from 'axios';

const Dashboard = () => {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchUsers = async () => {
      try {
        const response = await axios.get('http://localhost:5000/api/users');
        setUsers(response.data);
        setLoading(false);
      } catch (error) {
        console.error('Error fetching users:', error);
        setLoading(false);
      }
    };

    fetchUsers();
  }, []);

  if (loading) {
    return <div>Loading...</div>;
  }

  return (
    <div className="dashboard-container">
      <h1>User Dashboard</h1>
      <div className="user-list">
        {users.length > 0 ? (
          users.map((user) => (
            <div key={user._id} className="user-card">
              <h3>Address: {user.address}</h3>
              <div className="digital-ids">
                <p>Lens ID: {user.digitalIds.lensId || 'Not set'}</p>
                <p>Twitter: {user.digitalIds.twitter || 'Not set'}</p>
                <p>Telegram: {user.digitalIds.telegram || 'Not set'}</p>
                <p>Gitcoin Passport ID: {user.digitalIds.gitcoinPassportId || 'Not set'}</p>
                <p>ZKcat: {user.digitalIds.zkcat || 'Not set'}</p>
              </div>
            </div>
          ))
        ) : (
          <p>No users found.</p>
        )}
      </div>
    </div>
  );
};

export default Dashboard; 
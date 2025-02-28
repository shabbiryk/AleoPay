import React from 'react';
import { Link } from 'react-router-dom';

const Navbar = () => {
  return (
    <nav className="navbar">
      <div className="navbar-container">
        <Link to="/" className="navbar-logo">
          Invoice System
        </Link>
        <ul className="nav-menu">
          <li className="nav-item">
            <Link to="/" className="nav-links">Home</Link>
          </li>
          <li className="nav-item">
            <Link to="/dashboard" className="nav-links">Dashboard</Link>
          </li>
          <li className="nav-item">
            <Link to="/profile" className="nav-links">Profile</Link>
          </li>
        </ul>
      </div>
    </nav>
  );
};

export default Navbar; 
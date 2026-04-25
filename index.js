// js/index.js
import Utils from './utils.js';

// If user is already logged in, we optionally redirect them based on their role
document.addEventListener('DOMContentLoaded', () => {
  const user = Utils.storage.get('currentUser');
  if (user) {
    console.log('User logged in:', user.name);
    // Let them click the get started button which could be dynamically linked
    const btn = document.querySelector('.hero-actions .btn');
    if (btn) {
      btn.textContent = 'Go to Dashboard';
      btn.href = user.role === 'customer' 
        ? 'pages/customer/dashboard.html' 
        : 'pages/shopowner/dashboard.html';
    }
  }
});

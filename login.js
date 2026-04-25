// js/login.js
import Api from './api.js';
import Auth from './auth.js';
import Utils from './utils.js';

document.addEventListener('DOMContentLoaded', () => {
  // If already logged in, redirect
  const user = Utils.storage.get('currentUser');
  if (user) {
    window.location.href = user.role === 'customer' 
      ? Auth.getFrontendUrl('pages/customer/dashboard.html')
      : Auth.getFrontendUrl('pages/shopowner/dashboard.html');
  }

  const form = document.getElementById('login-form');
  
  form.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    const btn = form.querySelector('button');
    
    btn.disabled = true;
    btn.textContent = 'Logging in...';
    
    try {
      const res = await Api.login(email, password);
      if (res.success) {
        Auth.login(res.user);
      } else {
        Utils.showMsg('login-msg', res.message, true);
        btn.disabled = false;
        btn.textContent = 'Login';
      }
    } catch (err) {
      Utils.showMsg('login-msg', 'An error occurred. Please try again.', true);
      btn.disabled = false;
      btn.textContent = 'Login';
    }
  });
});

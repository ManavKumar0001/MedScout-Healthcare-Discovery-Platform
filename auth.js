// js/auth.js
import Utils from './utils.js';

const Auth = {
  getFrontendUrl: (path) => {
    return new URL(`../${path}`, import.meta.url).href;
  },

  checkAuth: () => {
    const user = Utils.storage.get('currentUser');
    if (!user) {
      window.location.href = Auth.getFrontendUrl('pages/login.html');
      return null;
    }
    return user;
  },

  checkRole: (requiredRole) => {
    const user = Auth.checkAuth();
    if (user && user.role !== requiredRole) {
      window.location.href = user.role === 'customer'
        ? Auth.getFrontendUrl('pages/customer/dashboard.html')
        : Auth.getFrontendUrl('pages/shopowner/dashboard.html');
    }
    return user;
  },

  login: (user) => {
    Utils.storage.set('currentUser', user);
    if (user.role === 'customer') {
      window.location.href = Auth.getFrontendUrl('pages/customer/dashboard.html');
    } else {
      window.location.href = Auth.getFrontendUrl('pages/shopowner/dashboard.html');
    }
  },

  logout: () => {
    Utils.storage.remove('currentUser');
    window.location.href = Auth.getFrontendUrl('pages/login.html');
  },

  setupLogoutBtn: () => {
    const btn = document.getElementById('logout-btn');
    if (btn) {
      btn.addEventListener('click', Auth.logout);
    }
  },

  setupTopbarInfo: () => {
    const el = document.getElementById('user-info');
    const user = Utils.storage.get('currentUser');
    if (el && user) {
      el.textContent = `Welcome, ${user.name}`;
    }
  }
};

export default Auth;

// js/shop-profile.js
import Api from './api.js';
import Auth from './auth.js';
import Utils from './utils.js';

document.addEventListener('DOMContentLoaded', () => {
  const user = Auth.checkRole('shopowner');
  if (!user) return;

  Auth.setupLogoutBtn();
  Auth.setupTopbarInfo();

  const form = document.getElementById('profile-form');
  const nameInput = document.getElementById('name');
  const emailInput = document.getElementById('email');
  const phoneInput = document.getElementById('phone');
  const shopNameInput = document.getElementById('shopName');
  const pincodeInput = document.getElementById('pincode');

  // Populate data
  nameInput.value = user.name || '';
  emailInput.value = user.email || '';
  phoneInput.value = user.phone || '';
  shopNameInput.value = user.shopName || '';
  pincodeInput.value = user.pincode || '';

  form.addEventListener('submit', async (e) => {
    e.preventDefault();
    const btn = form.querySelector('button');
    btn.disabled = true;
    btn.textContent = 'Updating...';

    const updateData = {
      name: nameInput.value,
      phone: phoneInput.value,
      shopName: shopNameInput.value,
      pincode: pincodeInput.value
    };

    try {
      const res = await Api.updateProfile(user.id, updateData);
      if (res.success) {
        Utils.storage.set('currentUser', res.user);
        Auth.setupTopbarInfo();
        Utils.showMsg('profile-msg', 'Profile updated successfully!');
      } else {
        Utils.showMsg('profile-msg', res.message, true);
      }
    } catch (err) {
      Utils.showMsg('profile-msg', 'An error occurred.', true);
    } finally {
      btn.disabled = false;
      btn.textContent = 'Update Profile';
    }
  });
});

// js/register.js
import Api from './api.js';
import Auth from './auth.js';
import Utils from './utils.js';

document.addEventListener('DOMContentLoaded', () => {
  const form = document.getElementById('register-form');
  const roleRadios = document.querySelectorAll('input[name="role"]');
  const shopFields = document.getElementById('shopowner-fields');
  const shopNameInput = document.getElementById('shopName');
  const pincodeInput = document.getElementById('pincode');

  // Toggle fields based on role
  roleRadios.forEach(radio => {
    radio.addEventListener('change', (e) => {
      if (e.target.value === 'shopowner') {
        shopFields.style.display = 'block';
        shopNameInput.required = true;
        pincodeInput.required = true;
      } else {
        shopFields.style.display = 'none';
        shopNameInput.required = false;
        pincodeInput.required = false;
      }
    });
  });

  form.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const elements = form.elements;
    const userData = {
      role: elements['role'].value,
      name: elements['name'].value,
      email: elements['email'].value,
      password: elements['password'].value,
      phone: elements['phone'].value,
    };

    if (userData.role === 'shopowner') {
      userData.shopName = elements['shopName'].value;
      userData.pincode = elements['pincode'].value;
    }

    const btn = form.querySelector('button');
    btn.disabled = true;
    btn.textContent = 'Registering...';

    try {
      const res = await Api.register(userData);
      if (res.success) {
        Auth.login(res.user);
      } else {
        Utils.showMsg('register-msg', res.message, true);
        btn.disabled = false;
        btn.textContent = 'Register';
      }
    } catch (err) {
      Utils.showMsg('register-msg', 'An error occurred. Please try again.', true);
      btn.disabled = false;
      btn.textContent = 'Register';
    }
  });
});

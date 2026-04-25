// js/api.js
import Utils from './utils.js';

const API_BASE = 'http://localhost:8080/api';

const fetchJson = async (endpoint, options = {}) => {
  try {
    const res = await fetch(`${API_BASE}${endpoint}`, {
      ...options,
      headers: {
        'Content-Type': 'application/json',
        ...(options.headers || {})
      }
    });
    
    if (!res.ok) {
      if (res.status === 405) {
        throw new Error('Method not allowed or endpoint not configured');
      }
      throw new Error(`Server returned ${res.status}`);
    }
    
    return await res.json();
  } catch (error) {
    console.error('API Error:', error);
    return { success: false, message: error.message || 'Network error' };
  }
};

const Api = {
  login: async (email, password) => {
    return fetchJson('/login', {
      method: 'POST',
      body: JSON.stringify({ email, password })
    });
  },

  register: async (userData) => {
    return fetchJson('/register', {
      method: 'POST',
      body: JSON.stringify(userData)
    });
  },

  // Shop APIs
  getShopMedicines: async (shopId) => {
    if (!shopId) return [];
    const data = await fetchJson(`/shop/medicines?shopId=${shopId}`);
    return Array.isArray(data) ? data : [];
  },

  addMedicine: async (medicineData) => {
    return fetchJson('/shop/medicines', {
      method: 'POST',
      body: JSON.stringify(medicineData)
    });
  },

  deleteMedicine: async (medId) => {
    return fetchJson(`/shop/medicines?id=${medId}`, {
      method: 'DELETE'
    });
  },

  // Customer APIs
  searchMedicines: async (query, pincode) => {
    let url = '/search?';
    if (query) url += `query=${encodeURIComponent(query)}&`;
    if (pincode) url += `pincode=${encodeURIComponent(pincode)}`;
    
    const data = await fetchJson(url);
    return Array.isArray(data) ? data : [];
  },

  updateProfile: async (userId, updateData) => {
    return fetchJson('/profile', {
      method: 'POST',
      body: JSON.stringify({ id: userId, ...updateData })
    });
  }
};

export default Api;

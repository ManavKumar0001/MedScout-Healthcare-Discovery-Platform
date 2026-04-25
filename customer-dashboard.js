// js/customer-dashboard.js
import Api from './api.js';
import Auth from './auth.js';
import Utils from './utils.js';

document.addEventListener('DOMContentLoaded', () => {
  Auth.checkRole('customer');
  Auth.setupLogoutBtn();
  Auth.setupTopbarInfo();

  const form = document.getElementById('search-form');
  const resultsContainer = document.getElementById('search-results');
  const loader = document.getElementById('results-loader');
  const noResults = document.getElementById('no-results');

  const renderMedicineCard = (med) => {
    const card = document.createElement('div');
    card.className = 'medicine-card';
    
    const stockClass = med.stock < 10 ? 'low' : '';
    const stockText = med.stock > 0 ? `${med.stock} in stock` : 'Out of stock';

    card.innerHTML = `
      <h4>${med.name}</h4>
      <p class="shop-name">🏪 ${med.shopName} (Pin: ${med.shopPincode})</p>
      <div style="font-size: 0.85rem; color: var(--text-light); margin-top: 0.25rem;">
        <span>📞 ${med.shopPhone || 'N/A'}</span> | 
        <span>✉️ ${med.ownerEmail || 'N/A'}</span>
      </div>
      <p style="color: var(--text-light); font-size: 0.9rem; margin-top: 0.75rem">${med.description || ''}</p>
      <div class="med-details">
        <span class="price">$${parseFloat(med.price).toFixed(2)}</span>
        <span class="stock ${stockClass}">${stockText}</span>
      </div>
    `;
    return card;
  };

  const loadResults = async (query = '', pincode = '') => {
    resultsContainer.innerHTML = '';
    noResults.style.display = 'none';
    loader.style.display = 'block';

    try {
      const results = await Api.searchMedicines(query, pincode);
      loader.style.display = 'none';

      if (results.length === 0) {
        noResults.style.display = 'block';
      } else {
        results.forEach(med => {
          resultsContainer.appendChild(renderMedicineCard(med));
        });
      }
    } catch (err) {
      loader.style.display = 'none';
      console.error(err);
    }
  };

  form.addEventListener('submit', (e) => {
    e.preventDefault();
    const query = document.getElementById('search-query').value;
    const pincode = document.getElementById('search-pincode').value;
    loadResults(query, pincode);
  });

  // Initial load
  loadResults();
});

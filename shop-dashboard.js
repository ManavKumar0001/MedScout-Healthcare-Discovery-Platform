// js/shop-dashboard.js
import Api from './api.js';
import Auth from './auth.js';

document.addEventListener('DOMContentLoaded', async () => {
  const user = Auth.checkRole('shopowner');
  if (!user) return;
  
  Auth.setupLogoutBtn();
  Auth.setupTopbarInfo();

  try {
    const medicines = await Api.getShopMedicines(user.shopId);
    
    // Stats
    document.getElementById('stat-total-medicines').textContent = medicines.length;
    
    const lowStock = medicines.filter(m => m.stock < 10).length;
    document.getElementById('stat-low-stock').textContent = lowStock;
    if (lowStock > 0) {
      document.getElementById('stat-low-stock').style.color = 'var(--danger-color)';
    }

    // Recent table - take last 5
    const recent = [...medicines].reverse().slice(0, 5);
    const tbody = document.getElementById('recent-table');
    
    if (recent.length === 0) {
      tbody.innerHTML = '<tr><td colspan="3" style="text-align:center;">No medicines found</td></tr>';
    } else {
      recent.forEach(med => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
          <td>${med.name}</td>
          <td>$${parseFloat(med.price).toFixed(2)}</td>
          <td>
            <span style="color: ${med.stock < 10 ? 'var(--danger-color)' : 'inherit'}; font-weight: 500;">
              ${med.stock}
            </span>
          </td>
        `;
        tbody.appendChild(tr);
      });
    }

  } catch (err) {
    console.error('Failed to load dashboard data', err);
  }
});

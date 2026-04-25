// js/shop-inventory.js
import Api from './api.js';
import Auth from './auth.js';
import Utils from './utils.js';

document.addEventListener('DOMContentLoaded', () => {
  const user = Auth.checkRole('shopowner');
  if (!user) return;

  Auth.setupLogoutBtn();
  Auth.setupTopbarInfo();

  const tbody = document.getElementById('inventory-table');
  const loader = document.getElementById('inventory-loader');
  const addForm = document.getElementById('add-med-form');

  const loadInventory = async () => {
    tbody.innerHTML = '';
    loader.style.display = 'block';

    try {
      const medicines = await Api.getShopMedicines(user.shopId);
      loader.style.display = 'none';

      if (medicines.length === 0) {
        tbody.innerHTML = '<tr><td colspan="5" style="text-align:center;">No medicines in inventory</td></tr>';
      } else {
        medicines.forEach(med => {
          const tr = document.createElement('tr');
          tr.innerHTML = `
            <td style="font-weight: 500;">${med.name}</td>
            <td style="color: var(--text-light); max-width: 250px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${med.description}</td>
            <td style="font-weight: 600;">$${parseFloat(med.price).toFixed(2)}</td>
            <td>
              <span style="color: ${med.stock < 10 ? 'var(--danger-color)' : 'inherit'};">
                ${med.stock}
              </span>
            </td>
            <td>
              <button class="btn btn-danger btn-small delete-btn" data-id="${med.id}">Delete</button>
            </td>
          `;
          tbody.appendChild(tr);
        });

        // Attach delete handlers
        document.querySelectorAll('.delete-btn').forEach(btn => {
          btn.addEventListener('click', async (e) => {
            const medId = e.target.getAttribute('data-id');
            if (confirm('Are you sure you want to delete this medicine?')) {
              e.target.disabled = true;
              e.target.textContent = '...';
              await Api.deleteMedicine(medId);
              loadInventory();
            }
          });
        });
      }
    } catch (err) {
      loader.style.display = 'none';
      console.error(err);
    }
  };

  addForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    const btn = addForm.querySelector('button');
    btn.disabled = true;

    const medData = {
      shopId: user.shopId,
      name: document.getElementById('med-name').value,
      price: parseFloat(document.getElementById('med-price').value),
      stock: parseInt(document.getElementById('med-stock').value, 10),
      description: document.getElementById('med-desc').value
    };

    try {
      const res = await Api.addMedicine(medData);
      if (res.success) {
        Utils.showMsg('med-msg', 'Medicine added successfully!');
        addForm.reset();
        loadInventory();
      } else {
        Utils.showMsg('med-msg', 'Failed to add medicine.', true);
      }
    } catch (err) {
      Utils.showMsg('med-msg', 'An error occurred.', true);
    } finally {
      btn.disabled = false;
    }
  });

  // Initial load
  loadInventory();
});

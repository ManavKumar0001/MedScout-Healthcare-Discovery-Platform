// js/utils.js
const Utils = {
  // Safe DOM selection
  el: (selector, context = document) => context.querySelector(selector),
  els: (selector, context = document) => context.querySelectorAll(selector),
  
  // Create HTML element with classes and attributes
  create: (tag, options = {}) => {
    const el = document.createElement(tag);
    if (options.className) el.className = options.className;
    if (options.id) el.id = options.id;
    if (options.text) el.textContent = options.text;
    if (options.html) el.innerHTML = options.html;
    if (options.attrs) {
      Object.entries(options.attrs).forEach(([k, v]) => el.setAttribute(k, v));
    }
    return el;
  },
  
  // Storage wrappers
  storage: {
    get: (key) => {
      const item = localStorage.getItem(key);
      if (!item || item === 'undefined') return null;
      try {
        return JSON.parse(item);
      } catch (e) {
        console.error('Failed to parse storage item:', key, e);
        return null;
      }
    },
    set: (key, value) => {
      localStorage.setItem(key, JSON.stringify(value));
    },
    remove: (key) => {
      localStorage.removeItem(key);
    }
  },

  // Show a generic message
  showMsg: (elementId, message, isError = false) => {
    const el = document.getElementById(elementId);
    if (!el) return;
    el.textContent = message;
    el.style.color = isError ? 'var(--danger-color)' : 'var(--secondary-color)';
    el.style.display = 'block';
    el.style.marginTop = '1rem';
    setTimeout(() => {
      el.style.display = 'none';
    }, 3000);
  }
};

export default Utils;

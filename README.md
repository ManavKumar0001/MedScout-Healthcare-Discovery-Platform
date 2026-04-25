# 🏥 MedScout — Intelligent Healthcare Discovery Platform

<div align="center">
  <img src="https://github.com/user-attachments/assets/0aa67016-6eaf-458a-adb2-6e31a0763ed6" alt="MedScout Banner" width="100%">

  <h2>Find Medicines Faster. Manage Inventory Smarter.</h2>
  <p>
    A modern full-stack healthcare platform that connects patients with nearby pharmacies  
    through real-time inventory tracking, intelligent search, and a premium UI experience.
  </p>

  <p>
    <img src="https://img.shields.io/badge/Frontend-React-blue?style=for-the-badge">
    <img src="https://img.shields.io/badge/Backend-Java-orange?style=for-the-badge">
    <img src="https://img.shields.io/badge/Database-MySQL-green?style=for-the-badge">
    <img src="https://img.shields.io/badge/Status-Active-success?style=for-the-badge">
  </p>
</div>

---

## 🌟 About the Project

**MedScout** is a **real-world healthcare solution** designed to solve a common problem:

> ❌ Patients don’t know where medicines are available
> ❌ Pharmacies lack digital visibility
> ❌ Time is wasted searching physically

### ✅ MedScout solves this by:

* Providing **real-time medicine availability**
* Enabling **location-based discovery**
* Offering **inventory management tools for shops**
* Delivering a **fast, modern, and intuitive UI**

---

## 🎯 Core Objectives

* 📍 Reduce time spent searching for medicines
* 🏥 Digitize local pharmacy ecosystems
* ⚡ Provide instant access to critical healthcare resources
* 📊 Enable smart inventory management for shop owners

---

## 🚀 Features

### 👤 Customer Features

* 🔍 **Smart Medicine Search**
  Search by brand name or generic composition

* 📍 **Pincode-Based Filtering**
  Find medicines available near your location

* 📦 **Real-Time Availability**
  Check stock status and pricing instantly

* 🏪 **Pharmacy Discovery**
  View shop details, contact info, and location

---

### 🏪 Shop Owner Features

* 📊 **Inventory Management System**
  Add, update, and remove medicines easily

* 💰 **Dynamic Pricing Control**
  Update prices and stock in real time

* 🧾 **Digital Shop Profile**
  Increase visibility and reach more customers

---

### 🔐 System Features

* 🔑 **Role-Based Authentication**
  Separate dashboards for customers and shop owners

* ⚡ **High-Performance Backend**
  Built with Java + JDBC for efficient database operations

* 🎨 **Premium UI Design**
  Midnight glassmorphism theme with smooth animations

---

## 🧠 System Architecture

```
Frontend (React + TypeScript)
        ↓
 REST API (HTTP Server - Java)
        ↓
   JDBC Layer
        ↓
   MySQL Database
```

---

## 🛠️ Tech Stack

### 💻 Frontend

* React
* TypeScript
* Vite
* Custom CSS (Glassmorphism Design System)

### ⚙️ Backend

* Java (Custom HTTP Server)
* JDBC

### 🗄️ Database

* MySQL 8.0+

### 🔗 Communication

* RESTful APIs

---

## ⚙️ Installation & Setup

### 📌 Prerequisites

Make sure you have:

* Node.js (v18+)
* Java JDK (v17+)
* MySQL Server

---

### 🗄️ Database Setup

1. Create database:

```sql
CREATE DATABASE medscout;
```

2. Import SQL files from:

```
/database
```

3. Update database credentials:

```java
DB_PASSWORD in backend/MedScoutBackend.java
```

---

### ⚙️ Backend Setup

```bash
cd backend

# Run backend server
./run.sh      # Linux/Mac
run.bat       # Windows
```

---

### 💻 Frontend Setup

```bash
cd frontend

# Install dependencies
npm install

# Start development server
npm run dev
```

---

## 📸 Screenshots (Add These)

> 🔥 Tip: Add UI screenshots here to make your repo look professional

* Dashboard
* Search Results
* Inventory Panel
* Login/Register Pages

---

## 🔮 Future Enhancements

* 🤖 AI-based medicine recommendation system
* 🚑 Emergency ambulance integration
* 📍 Live GPS tracking for pharmacies
* 📱 Mobile app (React Native)
* 🔔 Notification system for stock updates

---

## ⭐ Support

If you like this project:

* ⭐ Star the repo
* 🍴 Fork it
* 📢 Share it

---

<div align="center">
  <h3>🚀 Building the Future of Smart Healthcare</h3>
</div>

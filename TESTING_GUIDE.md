# 🧪 Backend Testing Guide - Prime Trade API

## 🚨 PowerShell Issue Fix

Since PowerShell has execution policy restrictions, follow these steps:

### Option 1: Use Command Prompt (Recommended)
```cmd
# Press Win + R, type: cmd, press Enter
# Then run these commands:

cd C:\Users\AbdulRehman\PrimeTrade-App\backend
npm install
npm start
```

### Option 2: Fix PowerShell Policy
```powershell
# Run PowerShell as Administrator
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
# Then run: npm install
```

## 📋 **Prerequisites Checklist**

Before testing, make sure:

### ✅ **XAMPP is Running**
1. Open XAMPP Control Panel
2. **Start Apache** (optional, but recommended)
3. **Start MySQL** (required!)
4. MySQL should show **green** status
5. Port 3306 should be available

### ✅ **Database is Imported**
1. Open phpMyAdmin (http://localhost/phpmyadmin)
2. Check if `primetrade_app` database exists
3. Should have tables: `users`, `products`, `categories`, etc.
4. Products table should have sample data

## 🚀 **Step-by-Step Testing**

### Step 1: Install Dependencies
```cmd
cd C:\Users\AbdulRehman\PrimeTrade-App\backend
npm install
```

**Expected output:**
```
added 50+ packages in 10s
```

### Step 2: Check Environment Configuration
The `.env` file should contain:
```
PORT=3000
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=primetrade_app
JWT_SECRET=primetrade-super-secret-key-change-in-production
```

### Step 3: Start the Server
```cmd
npm start
```

**Expected output:**
```
🚀 Prime Trade API server running on port 3000
✅ Database connected successfully
```

**If you see this, SUCCESS! Your backend is working!** 🎉

### Step 4: Test API Endpoints

Open a new Command Prompt/Terminal and test:

#### Test 1: Health Check
```cmd
curl http://localhost:3000/api/health
```
**Expected response:**
```json
{
  "status": "OK",
  "message": "Prime Trade API is running",
  "timestamp": "2025-08-08T05:59:00.000Z"
}
```

#### Test 2: Get Products
```cmd
curl http://localhost:3000/api/products
```
**Expected response:**
```json
[
  {
    "id": 1,
    "name": "ALF-CAM16 - IMPORTED ALUMINIUM FERROL 16MM",
    "price": "32.00",
    "category_name": "Aluminium Ferrules"
  }
]
```

#### Test 3: Get Categories
```cmd
curl http://localhost:3000/api/categories
```

## 🐛 **Common Issues & Solutions**

### Issue 1: "Database connection failed"
**Solution:**
- Make sure XAMPP MySQL is running
- Check if database `primetrade_app` exists
- Verify database credentials in `.env` file

### Issue 2: "Port 3000 already in use"
**Solution:**
```cmd
# Kill process using port 3000
netstat -ano | findstr :3000
taskkill /F /PID <process_id>
```

### Issue 3: "npm install failed"
**Solution:**
- Use Command Prompt instead of PowerShell
- Try: `npm install --force`
- Clear cache: `npm cache clean --force`

### Issue 4: "Cannot find module"
**Solution:**
```cmd
# Reinstall dependencies
rmdir /s node_modules
del package-lock.json
npm install
```

## 🧪 **Advanced Testing**

### Test User Registration
```cmd
curl -X POST http://localhost:3000/api/auth/register -H "Content-Type: application/json" -d "{\"email\":\"test@primetrade.pk\",\"password\":\"123456\",\"first_name\":\"Test\",\"last_name\":\"User\"}"
```

### Test User Login
```cmd
curl -X POST http://localhost:3000/api/auth/login -H "Content-Type: application/json" -d "{\"email\":\"test@primetrade.pk\",\"password\":\"123456\"}"
```

## 📱 **Browser Testing**

You can also test in your browser:
- **Health Check**: http://localhost:3000/api/health
- **Products**: http://localhost:3000/api/products
- **Categories**: http://localhost:3000/api/categories

## ✅ **Success Checklist**

When your backend is working correctly, you should see:
- [x] Server starts without errors
- [x] Database connection successful
- [x] Health check returns OK
- [x] Products API returns your imported products
- [x] Categories API returns categories
- [x] User registration works
- [x] User login works

## 🎯 **Next Steps After Successful Testing**

Once local testing works:
1. **Choose hosting platform** (Railway.app recommended)
2. **Deploy backend to free hosting**
3. **Update mobile app API URL**
4. **Test mobile app with hosted backend**

## 🆘 **Need Help?**

If you encounter issues:
1. **Check XAMPP MySQL** is running
2. **Use Command Prompt** instead of PowerShell
3. **Verify database** exists with correct name
4. **Check port 3000** is not in use

**Ready to test? Run the batch file or use Command Prompt!** 🚀

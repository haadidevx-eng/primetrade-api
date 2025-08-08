# 🚂 Railway.app Deployment Guide - Prime Trade API

## 🎯 **Step-by-Step Deployment**

### **Step 1: Create GitHub Repository**

1. **Go to GitHub.com** and sign in (create account if needed)
2. **Click "New Repository"**
3. **Repository Details:**
   - Name: `primetrade-api`
   - Description: `Prime Trade E-commerce API Backend`
   - Set to **Public** (required for free Railway)
   - ✅ **Initialize with README**

4. **Create Repository**

### **Step 2: Upload Your Backend Code**

**Option A: GitHub Web Interface (Easier)**
1. **Click "Upload files"** in your new repository
2. **Drag and drop ALL files** from your `backend` folder:
   - `server.js`
   - `package.json`
   - `.env.example`
   - `railway.json`
   - All other files
3. **Commit files** with message: "Initial Prime Trade API"

**Option B: Git Commands (If you have Git installed)**
```bash
git init
git add .
git commit -m "Initial Prime Trade API"
git remote add origin https://github.com/YOUR-USERNAME/primetrade-api.git
git push -u origin main
```

### **Step 3: Deploy to Railway**

1. **Go to railway.app**
2. **Click "Start a New Project"**
3. **Sign up with GitHub** (authorize Railway access)
4. **Choose "Deploy from GitHub repo"**
5. **Select your `primetrade-api` repository**
6. **Railway will automatically detect Node.js and deploy!**

### **Step 4: Add MySQL Database**

1. **In Railway dashboard, click "New Service"**
2. **Select "Database" → "MySQL"**
3. **Railway creates MySQL instance automatically**
4. **Copy database connection details** (we'll need these)

### **Step 5: Configure Environment Variables**

In Railway dashboard:
1. **Go to your API service**
2. **Click "Variables" tab**
3. **Add these variables:**

```
DB_HOST=mysql.railway.internal
DB_USER=root  
DB_PASSWORD=[Railway will provide]
DB_NAME=railway
DB_PORT=3306
JWT_SECRET=primetrade-super-secret-key-change-this
NODE_ENV=production
```

### **Step 6: Import Your Database**

1. **Get MySQL connection string** from Railway
2. **Use MySQL Workbench or phpMyAdmin** to connect
3. **Import your `schema.sql`** file to the Railway database
4. **Your products and categories will be online!**

### **Step 7: Test Deployment**

Railway will provide a URL like: `https://primetrade-api-production.up.railway.app`

**Test these endpoints:**
- Health: `https://your-app.railway.app/api/health`
- Products: `https://your-app.railway.app/api/products`
- Categories: `https://your-app.railway.app/api/categories`

## 🎯 **Expected Timeline:**

- **GitHub setup**: 5 minutes
- **Railway deployment**: 5 minutes  
- **Database import**: 10 minutes
- **Testing**: 5 minutes
- **Total**: ~25 minutes

## ✅ **Success Checklist:**

- [ ] GitHub repository created
- [ ] Code uploaded to GitHub
- [ ] Railway project deployed
- [ ] MySQL database added
- [ ] Environment variables set
- [ ] Database schema imported
- [ ] API endpoints responding
- [ ] Mobile app URL updated

## 🎉 **After Successful Deployment:**

You'll have:
- **Live API**: `https://your-app.railway.app`
- **Professional setup** ready for business
- **Scalable hosting** that grows with you
- **Custom domain** option available
- **SSL certificate** included (HTTPS)

## 💰 **Cost:**

- **Free**: $5/month credit (covers small business usage)
- **Paid**: Only if you exceed free limits (scales with success!)

## 🆘 **Need Help?**

If you get stuck:
1. **Railway has excellent docs** at docs.railway.app
2. **Their Discord community** is very helpful
3. **I can guide you** through any specific issues

**Ready to deploy? Start with Step 1 - Create GitHub repository!** 🚀

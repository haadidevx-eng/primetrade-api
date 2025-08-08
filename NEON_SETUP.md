# 🚀 Neon Database Setup for Prime Trade API

## Why Neon? ✅ FREE PostgreSQL Database

✅ **FREE Tier**: 0.5 GB storage, 100 compute hours/month  
✅ **No Credit Card Required**  
✅ **PostgreSQL Compatible**  
✅ **Auto-scaling**  
✅ **Perfect for Vercel deployment**

---

## Quick Setup Steps (5 minutes)

### 1. Create Neon Account
1. Go to **https://neon.tech**
2. Click "Sign Up" 
3. Sign up with GitHub (recommended) or email
4. Verify your email if needed

### 2. Create Your Database
1. Click **"Create Project"**
2. **Project Name**: `primetrade-app`
3. **Database Name**: `primetrade_app`
4. **Region**: Choose closest to you (e.g., US East, Europe)
5. Click **"Create Project"**

### 3. Get Your Connection String
After creating the project, you'll see a connection string like:
```
postgresql://username:password@ep-xxx-xxx.us-east-1.aws.neon.tech/primetrade_app?sslmode=require
```

**Copy this entire connection string!** 📋

### 4. Import Database Schema
1. In your Neon dashboard, click **"SQL Editor"**
2. Copy the entire contents of `schema-postgres.sql`
3. Paste it in the SQL Editor
4. Click **"Run"** to create all tables and sample data

### 5. Add to Vercel Environment Variables
In your Vercel project settings, add:
```
DATABASE_URL=postgresql://username:password@ep-xxx-xxx.us-east-1.aws.neon.tech/primetrade_app?sslmode=require
NODE_ENV=production
JWT_SECRET=primetrade-secret-key-2025
```

---

## ✅ Verification Steps

### Test Your Database Connection
After setup, your API endpoints should work:

1. **Health Check**: `https://your-app.vercel.app/api/health`  
   Should return: `"Prime Trade API is running with PostgreSQL"`

2. **Categories**: `https://your-app.vercel.app/api/categories`  
   Should return sample categories

3. **Products**: `https://your-app.vercel.app/api/products`  
   Should return sample products

---

## 📊 Database Overview

Your Neon database includes:

### **Core Tables**
- `users` - Customer accounts
- `admins` - Admin users  
- `categories` - Product categories
- `products` - Gaming accounts/items
- `carts` & `cart_items` - Shopping cart
- `orders` & `order_items` - Order management
- `wishlists` - User wishlists
- `reviews` - Product reviews

### **Sample Data Included**
- ✅ 4 Gaming categories (Valorant, PUBG, CS2, Fortnite)
- ✅ 4 Sample products with pricing
- ✅ Admin user: `admin@primetrade.com`
- ✅ Default settings

---

## 💡 Key Features

### **Free Tier Limits**
- **Storage**: 0.5 GB (plenty for e-commerce)
- **Compute**: 100 hours/month (auto-suspend when idle)
- **Connections**: Up to 100 concurrent
- **No time limit** on the free tier!

### **Production Ready**
- ✅ SSL/TLS encryption
- ✅ Connection pooling
- ✅ Backup & recovery
- ✅ Monitoring dashboard
- ✅ Auto-scaling

---

## 🔧 Advanced Configuration

### Connection Pooling (Optional)
For high traffic, add connection pooling:
```javascript
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  max: 20,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});
```

### Environment Variables
```env
DATABASE_URL=your-neon-connection-string
NODE_ENV=production
JWT_SECRET=primetrade-secret-key-2025
```

---

## 🚀 Next Steps

1. ✅ **Database**: Set up Neon (this step)
2. ⬆️ **Deploy**: Deploy to Vercel with environment variables
3. 🧪 **Test**: Verify all API endpoints work
4. 📱 **App**: Connect your React Native app
5. 🎉 **Launch**: Your Prime Trade API is ready!

---

## 📞 Support

- **Neon Docs**: https://neon.tech/docs
- **PostgreSQL Docs**: https://postgresql.org/docs
- **Your API**: Check `VERCEL_DEPLOYMENT.md` for deployment

**Your database is ready for production! 🎉**

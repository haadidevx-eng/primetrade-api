# Prime Trade API - Vercel Deployment Guide

## Files Ready for Deployment ✅

Your backend is now properly configured for Vercel deployment with these files:

- ✅ `vercel.json` - Vercel deployment configuration
- ✅ `index.js` - Entry point for Vercel
- ✅ `server.js` - Main API server
- ✅ `package.json` - Updated with build scripts
- ✅ All dependencies properly configured

## Quick Deployment Steps

### Option 1: GitHub Integration (Recommended)

1. **Push to GitHub** (if not already done):
   ```bash
   git init
   git add .
   git commit -m "Initial Prime Trade API setup"
   git branch -M main
   git remote add origin https://github.com/yourusername/primetrade-api.git
   git push -u origin main
   ```

2. **Deploy via Vercel Dashboard**:
   - Go to https://vercel.com/new
   - Connect your GitHub account
   - Select your `primetrade-api` repository
   - Configure environment variables (see below)
   - Click "Deploy"

### Option 2: Direct Upload

1. **Create ZIP file** with all files in this directory
2. **Go to Vercel Dashboard**: https://vercel.com/new
3. **Select "Browse"** and upload your ZIP file
4. **Configure environment variables** (see below)
5. **Deploy**

## Required Environment Variables

Add these in your Vercel project settings:

```
NODE_ENV=production
DB_HOST=your-planetscale-host.us-east-1.psdb.cloud
DB_USER=your-planetscale-username
DB_PASSWORD=your-planetscale-password
DB_NAME=primetrade_app
JWT_SECRET=primetrade-secret-key-2025
```

## Testing Your Deployment

Once deployed, test these endpoints:

- **Health Check**: `https://your-app.vercel.app/api/health`
- **Categories**: `https://your-app.vercel.app/api/categories`
- **Products**: `https://your-app.vercel.app/api/products`

## Database Setup

You'll need to:

1. **Create PlanetScale Database**:
   - Go to https://planetscale.com
   - Create new database: `primetrade_app`
   - Get connection details

2. **Import Schema**:
   - Use the `schema.sql` file provided
   - Import via PlanetScale dashboard or CLI

3. **Add Sample Data** (optional):
   - Run sample insert queries for categories and products

## Troubleshooting

- **404 Error**: Check if all files are uploaded correctly
- **500 Error**: Check environment variables and database connection
- **CORS Error**: Make sure CORS is properly configured in server.js

## Support

Your API includes these endpoints:
- Authentication: `/api/auth/login`, `/api/auth/register`
- Products: `/api/products`, `/api/products/featured`
- Categories: `/api/categories`
- Cart: `/api/cart` (protected)
- Orders: `/api/orders` (protected)

Ready for deployment! 🚀

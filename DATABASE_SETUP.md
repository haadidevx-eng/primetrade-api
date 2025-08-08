# PlanetScale Database Setup for Prime Trade API

## Quick Setup Steps

### 1. Create PlanetScale Account
- Go to https://planetscale.com
- Sign up with GitHub (recommended)
- Verify your email

### 2. Create Database
1. Click "Create Database"
2. Database name: `primetrade-app`
3. Region: Select closest to you (e.g., US East, Europe)
4. Click "Create database"

### 3. Get Connection Details
1. Go to your database dashboard
2. Click "Connect" button
3. Select "General" tab
4. Copy the connection details:
   ```
   Host: xxxxxxxxx.us-east-1.psdb.cloud
   Username: xxxxxxxxx
   Password: xxxxxxxxx
   ```

### 4. Import Schema
1. Click "Console" tab in your database
2. Copy and paste the contents of `schema.sql` file
3. Execute the SQL commands
4. Verify tables are created

### 5. Add to Vercel Environment Variables
In your Vercel project settings, add:
```
DB_HOST=your-planetscale-host.us-east-1.psdb.cloud
DB_USER=your-planetscale-username
DB_PASSWORD=your-planetscale-password
DB_NAME=primetrade_app
```

## Sample Data
After creating tables, you can add sample data:

```sql
-- Sample categories
INSERT INTO categories (name, description, image_url, is_active, sort_order) VALUES
('Gaming Accounts', 'Premium gaming accounts for various platforms', 'https://example.com/gaming.jpg', true, 1),
('Mobile Games', 'Mobile gaming accounts and resources', 'https://example.com/mobile.jpg', true, 2),
('PC Games', 'PC gaming accounts and items', 'https://example.com/pc.jpg', true, 3);

-- Sample products
INSERT INTO products (name, description, price, category_id, images, is_active, is_featured, stock_quantity) VALUES
('Valorant Premium Account', 'Valorant account with rare skins and high rank', 150.00, 1, '["https://example.com/valorant1.jpg"]', true, true, 5),
('PUBG Mobile UC', 'PUBG Mobile Unknown Cash for in-game purchases', 25.00, 2, '["https://example.com/pubg1.jpg"]', true, true, 100),
('CS2 Prime Account', 'Counter-Strike 2 Prime account with skins', 75.00, 3, '["https://example.com/cs2.jpg"]', true, false, 10);
```

## Testing Connection
After setup, test your API endpoints:
- Health: `https://your-api.vercel.app/api/health`
- Categories: `https://your-api.vercel.app/api/categories`
- Products: `https://your-api.vercel.app/api/products`

Your database is ready! 🚀

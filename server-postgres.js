// Prime Trade API Server - PostgreSQL Version
// Compatible with Neon Database and Vercel

const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Database connection
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false
});

// Test database connection
async function testConnection() {
  try {
    const client = await pool.connect();
    console.log('✅ PostgreSQL Database connected successfully');
    client.release();
  } catch (error) {
    console.error('❌ Database connection failed:', error);
  }
}

// JWT Secret
const JWT_SECRET = process.env.JWT_SECRET || 'primetrade-secret-key';

// Authentication middleware
const authenticateToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) {
    return res.status(401).json({ error: 'Access token required' });
  }

  jwt.verify(token, JWT_SECRET, (err, user) => {
    if (err) {
      return res.status(403).json({ error: 'Invalid token' });
    }
    req.user = user;
    next();
  });
};

// Routes

// Health check
app.get('/api/health', (req, res) => {
  res.json({ 
    status: 'OK', 
    message: 'Prime Trade API is running with PostgreSQL',
    timestamp: new Date().toISOString()
  });
});

// Auth Routes
app.post('/api/auth/register', async (req, res) => {
  try {
    const { email, password, first_name, last_name, phone } = req.body;

    // Check if user exists
    const existingUsers = await pool.query(
      'SELECT id FROM users WHERE email = $1',
      [email]
    );

    if (existingUsers.rows.length > 0) {
      return res.status(400).json({ error: 'User already exists' });
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Create user
    const result = await pool.query(
      'INSERT INTO users (email, password, first_name, last_name, phone) VALUES ($1, $2, $3, $4, $5) RETURNING id',
      [email, hashedPassword, first_name, last_name, phone]
    );

    const userId = result.rows[0].id;

    // Generate token
    const token = jwt.sign({ id: userId, email }, JWT_SECRET);

    res.status(201).json({
      message: 'User created successfully',
      user: { id: userId, email, first_name, last_name },
      token
    });
  } catch (error) {
    console.error('Registration error:', error);
    res.status(500).json({ error: 'Registration failed' });
  }
});

app.post('/api/auth/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    // Find user
    const users = await pool.query(
      'SELECT * FROM users WHERE email = $1 AND status = $2',
      [email, 'active']
    );

    if (users.rows.length === 0) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    const user = users.rows[0];

    // Verify password
    const validPassword = await bcrypt.compare(password, user.password);
    if (!validPassword) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    // Generate token
    const token = jwt.sign({ id: user.id, email: user.email }, JWT_SECRET);

    res.json({
      message: 'Login successful',
      user: {
        id: user.id,
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name
      },
      token
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ error: 'Login failed' });
  }
});

// Products Routes
app.get('/api/products', async (req, res) => {
  try {
    const { category, search, featured, limit = 20, offset = 0 } = req.query;
    
    let query = `
      SELECT p.*, c.name as category_name 
      FROM products p 
      LEFT JOIN categories c ON p.category_id = c.id 
      WHERE p.is_active = true
    `;
    const params = [];
    let paramIndex = 1;

    if (category) {
      query += ` AND p.category_id = $${paramIndex}`;
      params.push(category);
      paramIndex++;
    }

    if (search) {
      query += ` AND (p.name ILIKE $${paramIndex} OR p.description ILIKE $${paramIndex + 1})`;
      params.push(`%${search}%`, `%${search}%`);
      paramIndex += 2;
    }

    if (featured === 'true') {
      query += ' AND p.is_featured = true';
    }

    query += ` ORDER BY p.created_at DESC LIMIT $${paramIndex} OFFSET $${paramIndex + 1}`;
    params.push(parseInt(limit), parseInt(offset));

    const products = await pool.query(query, params);
    res.json(products.rows);
  } catch (error) {
    console.error('Products error:', error);
    res.status(500).json({ error: 'Failed to fetch products' });
  }
});

app.get('/api/products/featured', async (req, res) => {
  try {
    const products = await pool.query(`
      SELECT p.*, c.name as category_name 
      FROM products p 
      LEFT JOIN categories c ON p.category_id = c.id 
      WHERE p.is_active = true AND p.is_featured = true
      ORDER BY p.created_at DESC 
      LIMIT 10
    `);
    res.json(products.rows);
  } catch (error) {
    console.error('Featured products error:', error);
    res.status(500).json({ error: 'Failed to fetch featured products' });
  }
});

app.get('/api/products/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const products = await pool.query(`
      SELECT p.*, c.name as category_name 
      FROM products p 
      LEFT JOIN categories c ON p.category_id = c.id 
      WHERE p.id = $1 AND p.is_active = true
    `, [id]);

    if (products.rows.length === 0) {
      return res.status(404).json({ error: 'Product not found' });
    }

    res.json(products.rows[0]);
  } catch (error) {
    console.error('Product detail error:', error);
    res.status(500).json({ error: 'Failed to fetch product' });
  }
});

// Categories Routes
app.get('/api/categories', async (req, res) => {
  try {
    const categories = await pool.query(
      'SELECT * FROM categories WHERE is_active = true ORDER BY sort_order, name'
    );
    res.json(categories.rows);
  } catch (error) {
    console.error('Categories error:', error);
    res.status(500).json({ error: 'Failed to fetch categories' });
  }
});

// Cart Routes (Protected)
app.get('/api/cart', authenticateToken, async (req, res) => {
  try {
    const userId = req.user.id;
    
    const cartItems = await pool.query(`
      SELECT ci.*, p.name, p.price, p.images 
      FROM cart_items ci
      JOIN carts c ON ci.cart_id = c.id
      JOIN products p ON ci.product_id = p.id
      WHERE c.user_id = $1
    `, [userId]);

    res.json({ items: cartItems.rows });
  } catch (error) {
    console.error('Cart error:', error);
    res.status(500).json({ error: 'Failed to fetch cart' });
  }
});

app.post('/api/cart/add', authenticateToken, async (req, res) => {
  try {
    const userId = req.user.id;
    const { productId, quantity = 1 } = req.body;

    // Get or create cart
    let carts = await pool.query(
      'SELECT id FROM carts WHERE user_id = $1',
      [userId]
    );

    let cartId;
    if (carts.rows.length === 0) {
      const result = await pool.query(
        'INSERT INTO carts (user_id) VALUES ($1) RETURNING id',
        [userId]
      );
      cartId = result.rows[0].id;
    } else {
      cartId = carts.rows[0].id;
    }

    // Get product price
    const products = await pool.query(
      'SELECT price FROM products WHERE id = $1',
      [productId]
    );

    if (products.rows.length === 0) {
      return res.status(404).json({ error: 'Product not found' });
    }

    const price = products.rows[0].price;

    // Add or update cart item
    const existingItems = await pool.query(
      'SELECT id, quantity FROM cart_items WHERE cart_id = $1 AND product_id = $2',
      [cartId, productId]
    );

    if (existingItems.rows.length > 0) {
      // Update quantity
      await pool.query(
        'UPDATE cart_items SET quantity = quantity + $1, updated_at = NOW() WHERE id = $2',
        [quantity, existingItems.rows[0].id]
      );
    } else {
      // Add new item
      await pool.query(
        'INSERT INTO cart_items (cart_id, product_id, quantity, price) VALUES ($1, $2, $3, $4)',
        [cartId, productId, quantity, price]
      );
    }

    res.json({ message: 'Item added to cart' });
  } catch (error) {
    console.error('Add to cart error:', error);
    res.status(500).json({ error: 'Failed to add item to cart' });
  }
});

// Orders Routes (Protected)
app.get('/api/orders', authenticateToken, async (req, res) => {
  try {
    const userId = req.user.id;
    
    const orders = await pool.query(
      'SELECT * FROM orders WHERE user_id = $1 ORDER BY created_at DESC',
      [userId]
    );

    res.json(orders.rows);
  } catch (error) {
    console.error('Orders error:', error);
    res.status(500).json({ error: 'Failed to fetch orders' });
  }
});

// Start server
app.listen(PORT, () => {
  console.log(`🚀 Prime Trade API server running on port ${PORT}`);
  testConnection();
});

module.exports = app;

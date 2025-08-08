-- Prime Trade E-commerce Database Schema
-- Created for React Native Mobile Application

CREATE DATABASE IF NOT EXISTS primetrade_app;
USE primetrade_app;

-- Users table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    phone VARCHAR(20),
    date_of_birth DATE,
    gender ENUM('male', 'female', 'other'),
    profile_image VARCHAR(500),
    email_verified BOOLEAN DEFAULT FALSE,
    phone_verified BOOLEAN DEFAULT FALSE,
    status ENUM('active', 'inactive', 'suspended') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Admin users table
CREATE TABLE admin_users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    role ENUM('super_admin', 'admin', 'manager', 'staff') DEFAULT 'staff',
    permissions JSON,
    status ENUM('active', 'inactive') DEFAULT 'active',
    last_login TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Categories table
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    parent_id INT NULL,
    image VARCHAR(500),
    icon VARCHAR(100),
    sort_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    meta_title VARCHAR(255),
    meta_description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL
);

-- Products table
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(500) NOT NULL,
    slug VARCHAR(500) UNIQUE NOT NULL,
    description TEXT,
    short_description TEXT,
    sku VARCHAR(100) UNIQUE,
    barcode VARCHAR(100),
    category_id INT,
    brand VARCHAR(100),
    model VARCHAR(100),
    price DECIMAL(10,2) NOT NULL,
    compare_price DECIMAL(10,2),
    cost_price DECIMAL(10,2),
    stock_quantity INT DEFAULT 0,
    min_stock_level INT DEFAULT 5,
    weight DECIMAL(8,2),
    dimensions VARCHAR(100),
    images JSON,
    specifications JSON,
    features JSON,
    is_active BOOLEAN DEFAULT TRUE,
    is_featured BOOLEAN DEFAULT FALSE,
    rating DECIMAL(3,2) DEFAULT 0,
    rating_count INT DEFAULT 0,
    view_count INT DEFAULT 0,
    sold_count INT DEFAULT 0,
    meta_title VARCHAR(255),
    meta_description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL,
    INDEX idx_category (category_id),
    INDEX idx_sku (sku),
    INDEX idx_active (is_active),
    INDEX idx_featured (is_featured),
    FULLTEXT(name, description, short_description)
);

-- Product variants table (for different sizes, colors, etc.)
CREATE TABLE product_variants (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    sku VARCHAR(100) UNIQUE,
    price DECIMAL(10,2),
    stock_quantity INT DEFAULT 0,
    attributes JSON,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- User addresses table
CREATE TABLE user_addresses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    type ENUM('billing', 'shipping', 'both') DEFAULT 'both',
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    company VARCHAR(255),
    address_line_1 VARCHAR(255) NOT NULL,
    address_line_2 VARCHAR(255),
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100) DEFAULT 'Pakistan',
    phone VARCHAR(20),
    is_default BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Cart table
CREATE TABLE carts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    session_id VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user (user_id),
    INDEX idx_session (session_id)
);

-- Cart items table
CREATE TABLE cart_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    product_variant_id INT,
    quantity INT NOT NULL DEFAULT 1,
    price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (cart_id) REFERENCES carts(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (product_variant_id) REFERENCES product_variants(id) ON DELETE CASCADE
);

-- Orders table
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_number VARCHAR(50) UNIQUE NOT NULL,
    user_id INT,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    status ENUM('pending', 'confirmed', 'processing', 'shipped', 'delivered', 'cancelled', 'refunded') DEFAULT 'pending',
    payment_status ENUM('pending', 'paid', 'failed', 'refunded') DEFAULT 'pending',
    payment_method VARCHAR(50),
    payment_id VARCHAR(255),
    subtotal DECIMAL(10,2) NOT NULL,
    tax_amount DECIMAL(10,2) DEFAULT 0,
    shipping_amount DECIMAL(10,2) DEFAULT 0,
    discount_amount DECIMAL(10,2) DEFAULT 0,
    total_amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(10) DEFAULT 'PKR',
    notes TEXT,
    billing_address JSON,
    shipping_address JSON,
    tracking_number VARCHAR(100),
    shipped_at TIMESTAMP NULL,
    delivered_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_user (user_id),
    INDEX idx_status (status),
    INDEX idx_order_number (order_number)
);

-- Order items table
CREATE TABLE order_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    product_variant_id INT,
    product_name VARCHAR(500) NOT NULL,
    product_sku VARCHAR(100),
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (product_variant_id) REFERENCES product_variants(id) ON DELETE SET NULL
);

-- Wishlist table
CREATE TABLE wishlists (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    UNIQUE KEY unique_wishlist (user_id, product_id)
);

-- Product reviews table
CREATE TABLE product_reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    user_id INT NOT NULL,
    order_id INT,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    title VARCHAR(255),
    comment TEXT,
    images JSON,
    is_verified BOOLEAN DEFAULT FALSE,
    is_approved BOOLEAN DEFAULT TRUE,
    helpful_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE SET NULL
);

-- Coupons table
CREATE TABLE coupons (
    id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(50) UNIQUE NOT NULL,
    type ENUM('fixed', 'percentage') NOT NULL,
    value DECIMAL(10,2) NOT NULL,
    minimum_amount DECIMAL(10,2) DEFAULT 0,
    maximum_discount DECIMAL(10,2),
    usage_limit INT,
    used_count INT DEFAULT 0,
    user_limit INT DEFAULT 1,
    applicable_to ENUM('all', 'categories', 'products') DEFAULT 'all',
    applicable_ids JSON,
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Coupon usage tracking
CREATE TABLE coupon_usage (
    id INT PRIMARY KEY AUTO_INCREMENT,
    coupon_id INT NOT NULL,
    user_id INT NOT NULL,
    order_id INT NOT NULL,
    discount_amount DECIMAL(10,2) NOT NULL,
    used_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (coupon_id) REFERENCES coupons(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);

-- Notifications table
CREATE TABLE notifications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    type VARCHAR(50) NOT NULL,
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    data JSON,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_read (user_id, is_read)
);

-- Support tickets table
CREATE TABLE support_tickets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    subject VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    category VARCHAR(100),
    priority ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium',
    status ENUM('open', 'in_progress', 'resolved', 'closed') DEFAULT 'open',
    assigned_to INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (assigned_to) REFERENCES admin_users(id) ON DELETE SET NULL
);

-- Support ticket replies table
CREATE TABLE support_ticket_replies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ticket_id INT NOT NULL,
    user_id INT,
    admin_id INT,
    message TEXT NOT NULL,
    attachments JSON,
    is_internal BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES support_tickets(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (admin_id) REFERENCES admin_users(id) ON DELETE SET NULL
);

-- Settings table
CREATE TABLE settings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    key_name VARCHAR(100) UNIQUE NOT NULL,
    value TEXT,
    type VARCHAR(50) DEFAULT 'string',
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Analytics events table
CREATE TABLE analytics_events (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    session_id VARCHAR(255),
    event_type VARCHAR(100) NOT NULL,
    event_data JSON,
    user_agent TEXT,
    ip_address VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_event_type (event_type),
    INDEX idx_created_at (created_at)
);

-- Insert default admin user
INSERT INTO admin_users (email, password, name, role, permissions, status) VALUES 
('admin@primetrade.pk', '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Prime Trade Admin', 'super_admin', '{"all": true}', 'active');

-- Insert default categories based on Prime Trade website
INSERT INTO categories (name, slug, description, sort_order, is_active) VALUES
('Electrical LV', 'electrical-lv', 'Low Voltage Electrical Equipment', 1, TRUE),
('Electrical MV', 'electrical-mv', 'Medium Voltage Electrical Equipment', 2, TRUE),
('Wiring & Accessories', 'wiring-accessories', 'Electrical Wiring Components and Accessories', 3, TRUE),
('Electrical Equipment', 'electrical-equipment', 'Various Electrical Equipment and Components', 4, TRUE),
('Safety Devices', 'safety-devices', 'Electrical Safety Equipment and Devices', 5, TRUE),
('Meters & Indicators', 'meters-indicators', 'Electrical Meters and Indicator Equipment', 6, TRUE),
('Electrical Other Accessories', 'electrical-other-accessories', 'Other Electrical Accessories and Components', 7, TRUE);

-- Insert subcategories
INSERT INTO categories (name, slug, parent_id, sort_order, is_active) VALUES
('Aluminium Lugs', 'aluminium-lugs', 3, 1, TRUE),
('Copper Lugs', 'copper-lugs', 3, 2, TRUE),
('Bimetallic Lugs', 'bimetallic-lugs', 3, 3, TRUE),
('Aluminium Ferrules', 'aluminium-ferrules', 3, 4, TRUE),
('Copper Ferrules', 'copper-ferrules', 3, 5, TRUE),
('Cable Glands', 'cable-glands', 3, 6, TRUE),
('Busbars', 'busbars', 3, 7, TRUE),
('Cable Ties', 'cable-ties', 3, 8, TRUE),
('Cable Tie Mounts', 'cable-tie-mounts', 3, 9, TRUE),
('ACB Breakers', 'acb-breakers', 4, 1, TRUE),
('ATS Change Over', 'ats-change-over', 4, 2, TRUE),
('Contactors', 'contactors', 4, 3, TRUE),
('Control Relays', 'control-relays', 4, 4, TRUE),
('Capacitors', 'capacitors', 4, 5, TRUE),
('Trip Units', 'trip-units', 4, 6, TRUE),
('Earthing Switches', 'earthing-switches', 4, 7, TRUE),
('Earth Leakage Relays', 'earth-leakage-relays', 4, 8, TRUE),
('Buzzers & Bells', 'buzzers-bells', 5, 1, TRUE),
('Fire Alarm Panels', 'fire-alarm-panels', 5, 2, TRUE),
('Hooters', 'hooters', 5, 3, TRUE),
('Indicators & Alarm Switches', 'indicators-alarm-switches', 5, 4, TRUE),
('Ammeter Analog', 'ammeter-analog', 6, 1, TRUE),
('Ammeter Digital', 'ammeter-digital', 6, 2, TRUE),
('Voltmeters', 'voltmeters', 6, 3, TRUE),
('Energy Analyzers', 'energy-analyzers', 6, 4, TRUE);

-- Insert sample products based on Prime Trade website
INSERT INTO products (name, slug, description, short_description, sku, category_id, price, compare_price, stock_quantity, is_active, is_featured) VALUES
('ALF-CAM16 - IMPORTED ALUMINIUM FERROL 16MM', 'alf-cam16-imported-aluminium-ferrol-16mm', 'High quality imported aluminium ferrule 16MM for electrical connections', 'Imported aluminium ferrule 16MM', 'ALF-CAM16', 11, 32.00, 40.00, 100, TRUE, FALSE),
('ALF-CAM240 - IMPORTED ALUMINIUM FERROL 240MM', 'alf-cam240-imported-aluminium-ferrol-240mm', 'High quality imported aluminium ferrule 240MM for heavy duty electrical connections', 'Imported aluminium ferrule 240MM', 'ALF-CAM240', 11, 310.00, 350.00, 50, TRUE, TRUE),
('ALF-CAM25 - IMPORTED ALUMINIUM FERROL 25MM', 'alf-cam25-imported-aluminium-ferrol-25mm', 'High quality imported aluminium ferrule 25MM for electrical connections', 'Imported aluminium ferrule 25MM', 'ALF-CAM25', 11, 38.00, 45.00, 80, TRUE, FALSE),
('ALF-CAM300 - IMPORTED ALUMINIUM FERROL 300MM', 'alf-cam300-imported-aluminium-ferrol-300mm', 'High quality imported aluminium ferrule 300MM for heavy duty electrical connections', 'Imported aluminium ferrule 300MM', 'ALF-CAM300', 11, 290.00, 330.00, 30, TRUE, TRUE),
('ALF-CAM35 - IMPORTED ALUMINIUM FERROL 35MM', 'alf-cam35-imported-aluminium-ferrol-35mm', 'High quality imported aluminium ferrule 35MM for electrical connections', 'Imported aluminium ferrule 35MM', 'ALF-CAM35', 11, 68.00, 75.00, 60, TRUE, FALSE),
('ALF-CAM50 - IMPORTED ALUMINIUM FERROL 50MM', 'alf-cam50-imported-aluminium-ferrol-50mm', 'High quality imported aluminium ferrule 50MM for electrical connections', 'Imported aluminium ferrule 50MM', 'ALF-CAM50', 11, 80.00, 90.00, 70, TRUE, FALSE),
('ALF-CAM70 - IMPORTED ALUMINIUM FERROL 70MM', 'alf-cam70-imported-aluminium-ferrol-70mm', 'High quality imported aluminium ferrule 70MM for electrical connections', 'Imported aluminium ferrule 70MM', 'ALF-CAM70', 11, 120.00, 135.00, 45, TRUE, FALSE);

-- Insert default settings
INSERT INTO settings (key_name, value, description) VALUES
('site_name', 'Prime Trade', 'Website name'),
('site_description', 'Industrial Electrical Supplies', 'Website description'),
('contact_email', 'info@primetrade.pk', 'Contact email'),
('contact_phone', '021-35055416', 'Contact phone number'),
('currency', 'PKR', 'Default currency'),
('tax_rate', '0.00', 'Default tax rate'),
('shipping_fee', '0.00', 'Default shipping fee'),
('free_shipping_threshold', '5000.00', 'Minimum order for free shipping'),
('order_prefix', 'PT', 'Order number prefix'),
('enable_guest_checkout', 'true', 'Allow guest checkout'),
('enable_reviews', 'true', 'Enable product reviews'),
('enable_wishlist', 'true', 'Enable wishlist feature'),
('app_version', '1.0.0', 'Current app version'),
('maintenance_mode', 'false', 'Maintenance mode status');

-- Create indexes for better performance
CREATE INDEX idx_products_category_active ON products(category_id, is_active);
CREATE INDEX idx_products_featured ON products(is_featured, is_active);
CREATE INDEX idx_products_price ON products(price);
CREATE INDEX idx_orders_user_status ON orders(user_id, status);
CREATE INDEX idx_order_items_product ON order_items(product_id);
CREATE INDEX idx_cart_user_session ON carts(user_id, session_id);

-- Create triggers to update product rating
DELIMITER $$
CREATE TRIGGER update_product_rating AFTER INSERT ON product_reviews
FOR EACH ROW BEGIN
    UPDATE products SET 
        rating = (SELECT AVG(rating) FROM product_reviews WHERE product_id = NEW.product_id AND is_approved = TRUE),
        rating_count = (SELECT COUNT(*) FROM product_reviews WHERE product_id = NEW.product_id AND is_approved = TRUE)
    WHERE id = NEW.product_id;
END$$
DELIMITER ;

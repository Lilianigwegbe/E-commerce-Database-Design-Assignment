-- Script to create the e-commerce database schema

-- Drop tables if they exist (for development/testing purposes)
-- This is optional and should be used with caution in production
-- DROP TABLE IF EXISTS product_image;
-- DROP TABLE IF EXISTS product_item;
-- DROP TABLE IF EXISTS product_variation;
-- DROP TABLE IF EXISTS product_attribute;
-- DROP TABLE IF EXISTS product;
-- DROP TABLE IF EXISTS brand;
-- DROP TABLE IF EXISTS color;
-- DROP TABLE IF EXISTS size_option;
-- DROP TABLE IF EXISTS size_category;
-- DROP TABLE IF EXISTS product_category;
-- DROP TABLE IF EXISTS attribute_type;
-- DROP TABLE IF EXISTS attribute_category;


-- Create the brand table
CREATE TABLE brand (
    brand_id INT PRIMARY KEY AUTO_INCREMENT,
    brand_name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    logo_url VARCHAR(255),
    website_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Create the product_category table
CREATE TABLE product_category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
    parent_category_id INT,
    slug VARCHAR(100) UNIQUE, -- For SEO-friendly URLs
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_category_id) REFERENCES product_category(category_id)
);


-- Create the product_item table
 CREATE TABLE product_item (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    sku VARCHAR(100) UNIQUE NOT NULL, -- Stock Keeping Unit - unique identifier for this specific item
    color_id INT,
    -- other variation IDs can be added here as foreign keys if you choose a more rigid variation structure
    -- e.g., size_option_id INT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT UNSIGNED DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id)
    -- FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id) -- if you include size as a direct FK
);


-- Create the product_image table
CREATE TABLE product_image (
    image_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    is_thumbnail BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);


-- Create the color table
CREATE TABLE color (
    color_id INT PRIMARY KEY AUTO_INCREMENT,
    color_name VARCHAR(50) NOT NULL,
    color_code VARCHAR(20) UNIQUE NOT NULL, -- e.g., #FF0000 for Red
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Create the product table
CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    base_price DECIMAL(10, 2) NOT NULL,
    description TEXT,
    slug VARCHAR(255) UNIQUE, -- For SEO-friendly URLs
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);


-- Create the product_variation table
CREATE TABLE product_variation (
    variation_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    variation_name VARCHAR(50) NOT NULL, -- e.g., "Size", "Color"
    variation_value VARCHAR(50) NOT NULL, -- e.g., "S", "Red"
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    UNIQUE (product_id, variation_name, variation_value)
);


-- Create the size_category table
CREATE TABLE size_category (
    size_category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Create the size_option table
CREATE TABLE size_option (
    size_option_id INT PRIMARY KEY AUTO_INCREMENT,
    size_category_id INT NOT NULL,
    size_value VARCHAR(20) NOT NULL,
    UNIQUE (size_category_id, size_value),
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);


-- Create the product_attribute table
CREATE TABLE product_attribute (
    attribute_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    attribute_category_id INT NOT NULL,
    attribute_type_id INT NOT NULL,
    attribute_value VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id),
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id)
);


-- Create the attribute_category table
CREATE TABLE attribute_category (
    attribute_category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) UNIQUE NOT NULL
);


-- Create the attribute_type table
CREATE TABLE attribute_type (
    attribute_type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50) UNIQUE NOT NULL
);


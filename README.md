# E-commerce-Database-Design-Assignment

## Overview

This project is a database design for an e-commerce platform. The design includes an Entity-Relationship Diagram (ERD) and a SQL script (`ecommerce.sql`) to create the database schema. This project was created as part of a database design assignment.

## Project Structure

* **`README.md`**: This file, providing an overview of the project.
* **`ecommerce.sql`**: A SQL script containing the `CREATE TABLE` statements to set up the database schema.
* ** `ERD.png`**: A file containing the Entity-Relationship Diagram (ERD) in image format.

## Database Schema

The database schema consists of the following tables:

`product_image`: Stores product image URLs or file references.
`color`: Manages available color options.
`product_category`: Classifies products into categories (e.g., clothing, electronics).
`product`: Stores general product details (name, brand, base price).
`product_item`: Represents purchasable items with specific variations.
`brand`: Stores brand-related data.
`product_variation`: Links a product to its variations (e.g., size, color).
`size_category`: Groups sizes into categories (e.g., clothing sizes, shoe sizes).
`size_option`: Lists specific sizes (e.g., S, M, L, 42).
`product_attribute`: Stores custom attributes (e.g., material, weight).
`attribute_category`: Groups attributes into categories (e.g., physical, technical).
`attribute_type`: Defines types of attributes (e.g., text, number, boolean).

## Entity-Relationship Diagram (ERD)

The ERD illustrates the relationships between the tables in the database.  It shows how the entities are related to each other, and the attributes of each entity.

Image of ERD -  [https://dbdiagram.io/d/680c0be81ca52373f56a0c03]

erDiagram
    product_image ||--o{ product : product_id
    color ||--o{ product_item : color_id
    product_category ||--o{ product : category_id
    brand ||--o{ product : brand_id
    product ||--o{ product_item : product_id
    product ||--o{ product_variation : product_id
    size_category ||--o{ size_option : size_category_id
    size_option ||--o{ product_variation : size_option_id
    product ||--o{ product_attribute : product_id
    attribute_category ||--o{ product_attribute : attribute_category_id
    attribute_type ||--o{ product_attribute : attribute_type_id

    product_image {
        INT image_id PK
        INT product_id FK
        VARCHAR image_url
        BOOLEAN is_thumbnail
    }

    color {
        INT color_id PK
        VARCHAR color_name
        VARCHAR color_code
        DATETIME created_at
        DATETIME updated_at
    }

    product_category {
        INT category_id PK
        VARCHAR category_name
        INT parent_category_id FK
        VARCHAR slug
        TEXT description
        DATETIME created_at
        DATETIME updated_at
    }

    product {
        INT product_id PK
        INT brand_id FK
        INT category_id FK
        VARCHAR product_name
        DECIMAL base_price
        TEXT description
        VARCHAR slug
        DATETIME created_at
        DATETIME updated_at
    }

    product_item {
        INT item_id PK
        INT product_id FK
        VARCHAR sku UNIQUE
        INT color_id FK
        DECIMAL price
        INT stock_quantity
        BOOLEAN is_active
        DATETIME created_at
        DATETIME updated_at
    }

    brand {
        INT brand_id PK
        VARCHAR brand_name UNIQUE
        TEXT description
        VARCHAR logo_url
        VARCHAR website_url
        DATETIME created_at
        DATETIME updated_at
    }

    product_variation {
        INT variation_id PK
        INT product_id FK
        VARCHAR variation_name
        VARCHAR variation_value
        UNIQUE (product_id, variation_name, variation_value)
    }

    size_category {
        INT size_category_id PK
        VARCHAR category_name UNIQUE
        TEXT description
        DATETIME created_at
        DATETIME updated_at
    }

    size_option {
        INT size_option_id PK
        INT size_category_id FK
        VARCHAR size_value
        UNIQUE (size_category_id, size_value)
    }

    product_attribute {
        INT attribute_id PK
        INT product_id FK
        INT attribute_category_id FK
        INT attribute_type_id FK
        VARCHAR attribute_value
    }

    attribute_category {
        INT attribute_category_id PK
        VARCHAR category_name UNIQUE
    }

    attribute_type {
        INT attribute_type_id PK
        VARCHAR type_name UNIQUE
    }

I could not get collaborators in group 98. So, I worked on the assignment on my group's behalf.

Author: Lilian Igwegbe
# Part 2: NoSQL Database Implementation

## Overview

This part of the FlexiMart Data Architecture project explores NoSQL database implementation using MongoDB for flexible product catalog management.

## Project Structure

```
part2-nosql/
├── MongoDB_Task2.2/
│   ├── mongodb_operations.js    # MongoDB operations script
│   ├── package.json             # Node.js dependencies
│   ├── products_catalog.json    # Sample product data
│   └── nosql_analysis.md        # MongoDB analysis documentation
├── NoSQL Justification Report_task2.1/
│   └── nosql_analysis.md        # RDBMS vs NoSQL justification
└── README.md                    # This file
```

## Why NoSQL for FlexiMart?

### Limitations of RDBMS Addressed

1. **Variable Product Attributes**: Different products require different specifications
2. **Schema Flexibility**: Easy to add new product types without ALTER TABLE operations
3. **Embedded Data**: Reviews stored directly within product documents
4. **Scalability**: Horizontal scaling through sharding

## MongoDB Data Model

```javascript
{
  product_id: "ELEC001",
  name: "Samsung Galaxy S21 Ultra",
  category: "Electronics",
  price: 79999.00,
  specifications: { brand: "Samsung", ram: "12GB" },
  reviews: [ { user_id: "U001", rating: 5 } ],
  tags: ["flagship", "5G"]
}
```

## MongoDB Operations

| Operation | Description |
|-----------|-------------|
| 1. Load Data | Bulk inserts 12 products |
| 2. Basic Query | Electronics under 50000 |
| 3. Review Analysis | Average rating per product |
| 4. Update | Add review using $push |
| 5. Aggregation | Price stats by category |

## Product Categories

### Electronics (6 products)
- Samsung Galaxy S21 Ultra, Apple MacBook Pro, Sony WH-1000XM5
- Dell 4K Monitor, OnePlus Nord CE 3, Samsung QLED TV

### Fashion (6 products)
- Levis Jeans, Nike Air Max, Adidas T-Shirt
- Puma RS-X, H&M Formal Shirt, Reebok Trackpants

## Setup

```bash
cd MongoDB_Task2.2
npm install
mongod --dbpath /path/to/data
node mongodb_operations.js
```

## Dependencies

- **mongodb ^7.0.0** - Official MongoDB driver

## Aggregation Stages

| Stage | Purpose |
|-------|---------|
| $match | Filter documents |
| $project | Select fields |
| $group | Group and aggregate |
| $sort | Order results |
| $unwind | Deconstruct arrays |

## Comparison with Part 1

| Aspect | MySQL | MongoDB |
|--------|-------|--------|
| Data Model | Tables | Documents |
| Schema | Fixed | Flexible |
| Queries | SQL JOINs | Aggregation |
| Scaling | Vertical | Horizontal |


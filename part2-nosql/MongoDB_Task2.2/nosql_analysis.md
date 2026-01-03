# NoSQL Analysis Report

## 1. Introduction to NoSQL Databases and MongoDB

### What is NoSQL?
NoSQL (Not Only SQL) databases are non-relational database systems designed for flexible data models, horizontal scaling, and high performance with unstructured or semi-structured data. Unlike traditional SQL databases that use fixed schemas and tables, NoSQL databases offer more flexibility in data representation.

### Types of NoSQL Databases:
- **Document Stores** (MongoDB, CouchDB) - Store data as JSON-like documents
- **Key-Value Stores** (Redis, DynamoDB) - Simple pairs of keys and values
- **Column-Family Stores** (Cassandra, HBase) - Store data in columns rather than rows
- **Graph Databases** (Neo4j) - Represent data as nodes and relationships

### Why MongoDB?
MongoDB is a leading document-based NoSQL database that stores data in flexible, JSON-like BSON documents. Key advantages include:
- **Schema Flexibility**: Documents in a collection can have different fields
- **Horizontal Scalability**: Built-in sharding for distributed data
- **Rich Query Language**: Supports complex queries, aggregations, and indexing
- **Native Replication**: Automatic failover and data redundancy
- **Index Support**: Create indexes on any field for faster queries

### MongoDB vs Traditional SQL:
| Aspect | MongoDB (NoSQL) | SQL Databases |
|--------|-----------------|---------------|
| Data Model | Collections & Documents | Tables & Rows |
| Schema | Dynamic/Flexible | Fixed |
| Query Language | MongoDB Query Language | SQL |
| Relationships | Embedding & Referencing | Joins |
| Scaling | Horizontal | Vertical |

---

## 2. MongoDB Data Modeling and Document Structure

### Document Structure in MongoDB
MongoDB stores data as BSON (Binary JSON) documents, which are JSON-like structures with additional data types. A typical document structure includes:

```javascript
{
  _id: ObjectId("..."),
  field1: value1,
  field2: { nested: "object" },
  arrayField: [1, 2, 3],
  dateField: ISODate("...")
}
```

### Data Modeling Approaches

#### Embedded Data Model (Denormalized)
Embed related data within a single document. Best for:
- One-to-few relationships
- Data that is frequently accessed together
- Small to medium sized related data

**Example from our products_catalog:**
```javascript
{
  product_id: "ELEC001",
  name: "Samsung Galaxy S21 Ultra",
  specifications: {
    brand: "Samsung",
    ram: "12GB",
    storage: "256GB"
  },
  reviews: [
    { user_id: "U001", rating: 5, comment: "Excellent!" },
    { user_id: "U012", rating: 4, comment: "Great performance" }
  ]
}
```

#### Referenced Data Model (Normalized)
Use document references (like foreign keys) to link related documents. Best for:
- Many-to-many relationships
- Large arrays of subdocuments
- Data that changes frequently

### Designing for Our Product Catalog
For the products catalog, we chose the **embedded data model** because:
- Reviews are tightly coupled to products
- Product specifications are inherent to the product
- We need atomic reads of complete product information
- Updates to product data don't affect multiple collections

### Indexing Strategies
Proper indexing is crucial for performance:
```javascript
// Create indexes for common query patterns
db.products.createIndex({ product_id: 1 })
db.products.createIndex({ category: 1 })
db.products.createIndex({ price: 1 })
db.products.createIndex({ "reviews.rating": 1 })
```

---

## 3. MongoDB Aggregation Framework and Use Cases

### What is the Aggregation Framework?
MongoDB's aggregation framework is a powerful pipeline-based data processing system. It allows you to transform, filter, and aggregate data through a series of stages, where each stage processes the output of the previous stage.

### Aggregation Pipeline Stages

| Stage | Purpose | Example |
|-------|---------|---------|
| `$match` | Filter documents (like WHERE) | `{ $match: { category: "Electronics" } }` |
| `$project` | Include/exclude/transform fields (SELECT) | `{ $project: { name: 1, price: 1 } }` |
| `$group` | Group documents and calculate aggregates | `{ $group: { _id: "$category", avg: { $avg: "$price" } } }` |
| `$sort` | Sort documents | `{ $sort: { price: -1 } }` |
| `$limit` | Limit results | `{ $limit: 10 }` |
| `$skip` | Skip documents | `{ $skip: 5 }` |
| `$unwind` | Deconstruct arrays | `{ $unwind: "$reviews" }` |
| `$lookup` | Perform joins (left outer join) | `{ $lookup: { from: "orders", localField: "_id", foreignField: "productId", as: "orders" } }` |

### Aggregation Operators

#### Arithmetic Operators
- `$add`, `$subtract`, `$multiply`, `$divide`, `$mod`

#### Array Operators
- `$push`, `$addToSet`, `$filter`, `$map`, `$size`

#### Comparison Operators
- `$eq`, `$ne`, `$gt`, `$gte`, `$lt`, `$lte`

#### Accumulator Operators (used in `$group`)
- `$sum`, `$avg`, `$min`, `$max`, `$first`, `$last`, `$push`

### Use Case Examples

#### 1. Calculate Average Rating per Product
```javascript
db.products.aggregate([
  { $unwind: "$reviews" },
  { $group: {
      _id: "$product_id",
      avgRating: { $avg: "$reviews.rating" }
  }},
  { $match: { avgRating: { $gte: 4 } } }
])
```

#### 2. Price Analysis by Category
```javascript
db.products.aggregate([
  { $group: {
      _id: "$category",
      avgPrice: { $avg: "$price" },
      totalProducts: { $sum: 1 },
      maxPrice: { $max: "$price" },
      minPrice: { $min: "$price" }
  }},
  { $sort: { avgPrice: -1 } }
])
```

#### 3. Find Products with Low Stock
```javascript
db.products.aggregate([
  { $match: { stock: { $lt: 50 } } },
  { $project: {
      name: 1,
      stock: 1,
      category: 1,
      status: {
        $cond: { if: { $lt: ["$stock", 20] }, then: "Critical", else: "Low" }
      }
  }},
  { $sort: { stock: 1 } }
])
```

### Why Use Aggregation Instead of Map-Reduce?
- **Simpler Syntax**: Pipeline syntax is more intuitive than Map-Reduce functions
- **Better Performance**: Optimized execution engine
- **Real-time Processing**: Suitable for interactive queries
- **Flexible Pipeline**: Easy to add/remove stages

### Best Practices for Aggregation
1. **Put `$match` early**: Filter documents before expensive operations
2. **Limit `$project` fields**: Only include necessary fields
3. **Use `$unwind` carefully**: Can significantly increase document count
4. **Index filter fields**: Create indexes on fields used in `$match`
5. **Use `$facet` for multiple aggregations**: Run multiple pipelines in one query

---

## Conclusion

MongoDB provides a flexible, scalable solution for modern application development. Its document-based model aligns well with how applications naturally structure data, while the aggregation framework enables powerful analytics and reporting capabilities. For our product catalog system, MongoDB's features enable efficient product management, review analysis, and category-based analytics.


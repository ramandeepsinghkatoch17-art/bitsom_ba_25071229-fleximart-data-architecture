# NoSQL Justification Report – FlexiMart

## Section A: Limitations of RDBMS

Relational databases like MySQL work well for structured and predictable data, but they struggle when handling highly variable product information. In FlexiMart, different products have different attributes. For example, laptops require attributes such as RAM, processor, and storage, while shoes require size, color, and material. In an RDBMS, accommodating these differences would require either adding many nullable columns or creating multiple product-specific tables, leading to poor design and maintenance complexity.

Frequent schema changes are another limitation. When new product types are introduced, ALTER TABLE operations are required, which can be time-consuming and risky for large datasets. This makes rapid business changes difficult to implement.

Additionally, storing customer reviews as nested data is inefficient in relational databases. Reviews would require separate tables and complex joins to retrieve product details along with reviews. This increases query complexity and reduces performance, especially when dealing with large volumes of review data.


## Section B: NoSQL Benefits

MongoDB addresses the limitations of relational databases by using a flexible, document-based schema. Each product is stored as a document, allowing different products to have different attributes without enforcing a fixed structure. For example, a laptop document can include RAM and processor fields, while a shoe document can include size and color, all within the same collection.

MongoDB also supports embedded documents, which allows customer reviews to be stored directly inside the product document. This makes it easy to retrieve a product along with its reviews in a single query, improving performance and simplifying data access.

Another key advantage is horizontal scalability. MongoDB supports sharding, which allows data to be distributed across multiple servers. This is especially useful for an e-commerce platform like FlexiMart, where the product catalog and review data can grow rapidly. As data volume increases, MongoDB can scale efficiently without major architectural changes.


## Section C: Trade-offs

One disadvantage of using MongoDB instead of MySQL is the lack of strong relational constraints. MongoDB does not enforce foreign key relationships, which can lead to data inconsistency if not handled properly at the application level.

Another drawback is complex transaction handling. Although MongoDB supports transactions, they are generally less mature and efficient compared to relational databases for multi-table transactional operations. For scenarios involving complex joins and strict ACID compliance, MySQL may be more suitable. Therefore, MongoDB is best used where flexibility and scalability are more important than strict relational integrity.



// CONFIGURATION


const { MongoClient } = require('mongodb');

// MongoDB connection URI (update with your local MongoDB settings)
const MONGO_URI = 'mongodb://localhost:27017';
const DATABASE_NAME = 'product_catalog_db';
const COLLECTION_NAME = 'products';


// - Connect to MongoDB


async function connectToMongoDB() {
    const client = new MongoClient(MONGO_URI);
    try {
        await client.connect();
        console.log('✓ Connected to MongoDB successfully');
        return client;
    } catch (error) {
        console.error('✗ Failed to connect to MongoDB:', error.message);
        throw error;
    }
}


// OPERATION 1: Load Data

async function loadData(client) {
    const db = client.db(DATABASE_NAME);
    const collection = db.collection(COLLECTION_NAME);
    
    
    try {
        await collection.deleteMany({});
        console.log('✓ Cleared existing data from collection');
    } catch (error) {
        console.log('! Collection may not exist yet, proceeding with insert');
    }
    
    
    
    const products = [
        {
            "product_id": "ELEC001",
            "name": "Samsung Galaxy S21 Ultra",
            "category": "Electronics",
            "subcategory": "Smartphones",
            "price": 79999.00,
            "stock": 150,
            "specifications": {
                "brand": "Samsung",
                "ram": "12GB",
                "storage": "256GB",
                "screen_size": "6.8 inches",
                "processor": "Exynos 2100",
                "battery": "5000mAh",
                "camera": "108MP + 12MP + 10MP"
            },
            "reviews": [
                { "user_id": "U001", "username": "TechGuru", "rating": 5, "comment": "Excellent phone with amazing camera quality!", "date": "2024-01-15" },
                { "user_id": "U012", "username": "MobileUser", "rating": 4, "comment": "Great performance but a bit pricey.", "date": "2024-02-10" },
                { "user_id": "U023", "username": "PhotoEnthusiast", "rating": 5, "comment": "Best camera phone I've ever used!", "date": "2024-03-05" }
            ],
            "tags": ["flagship", "5G", "android", "photography"],
            "warranty_months": 12,
            "created_at": new Date("2023-12-01T10:00:00Z"),
            "updated_at": new Date("2024-03-20T14:30:00Z")
        },
        {
            "product_id": "ELEC002",
            "name": "Apple MacBook Pro 14-inch",
            "category": "Electronics",
            "subcategory": "Laptops",
            "price": 189999.00,
            "stock": 45,
            "specifications": {
                "brand": "Apple",
                "processor": "M2 Pro",
                "ram": "16GB",
                "storage": "512GB SSD",
                "screen_size": "14 inches",
                "graphics": "Integrated GPU",
                "weight": "1.6 kg"
            },
            "reviews": [
                { "user_id": "U005", "username": "DevPro", "rating": 5, "comment": "Perfect for development work. Battery life is incredible!", "date": "2024-01-20" },
                { "user_id": "U018", "username": "Designer123", "rating": 5, "comment": "Handles heavy design software smoothly.", "date": "2024-02-15" }
            ],
            "tags": ["laptop", "macOS", "professional", "M2"],
            "warranty_months": 12,
            "created_at": new Date("2023-11-15T09:00:00Z"),
            "updated_at": new Date("2024-03-18T11:20:00Z")
        },
        {
            "product_id": "ELEC003",
            "name": "Sony WH-1000XM5 Headphones",
            "category": "Electronics",
            "subcategory": "Audio",
            "price": 29990.00,
            "stock": 200,
            "specifications": {
                "brand": "Sony",
                "type": "Over-ear",
                "connectivity": "Bluetooth 5.2",
                "noise_cancellation": "Active",
                "battery_life": "30 hours",
                "weight": "250g"
            },
            "reviews": [
                { "user_id": "U007", "username": "MusicLover", "rating": 5, "comment": "Best noise cancellation in the market!", "date": "2024-01-25" },
                { "user_id": "U014", "username": "Audiophile", "rating": 4, "comment": "Great sound quality, very comfortable for long use.", "date": "2024-02-20" },
                { "user_id": "U029", "username": "Traveler", "rating": 5, "comment": "Perfect for flights and commutes!", "date": "2024-03-10" }
            ],
            "tags": ["headphones", "wireless", "noise-cancelling", "premium"],
            "warranty_months": 24,
            "created_at": new Date("2023-10-20T08:00:00Z"),
            "updated_at": new Date("2024-03-22T16:45:00Z")
        },
        {
            "product_id": "ELEC004",
            "name": "Dell 27-inch 4K Monitor",
            "category": "Electronics",
            "subcategory": "Monitors",
            "price": 32999.00,
            "stock": 60,
            "specifications": {
                "brand": "Dell",
                "screen_size": "27 inches",
                "resolution": "3840x2160 (4K)",
                "refresh_rate": "60Hz",
                "panel_type": "IPS",
                "connectivity": "HDMI, DisplayPort, USB-C"
            },
            "reviews": [
                { "user_id": "U003", "username": "GraphicDesigner", "rating": 5, "comment": "Colors are accurate and vibrant. Perfect for design work.", "date": "2024-02-01" },
                { "user_id": "U021", "username": "Gamer99", "rating": 3, "comment": "Good for work but only 60Hz, not ideal for gaming.", "date": "2024-03-01" }
            ],
            "tags": ["monitor", "4K", "professional", "IPS"],
            "warranty_months": 36,
            "created_at": new Date("2023-11-10T10:30:00Z"),
            "updated_at": new Date("2024-03-15T09:15:00Z")
        },
        {
            "product_id": "ELEC005",
            "name": "OnePlus Nord CE 3",
            "category": "Electronics",
            "subcategory": "Smartphones",
            "price": 26999.00,
            "stock": 180,
            "specifications": {
                "brand": "OnePlus",
                "ram": "8GB",
                "storage": "128GB",
                "screen_size": "6.7 inches",
                "processor": "Snapdragon 782G",
                "battery": "5000mAh",
                "camera": "50MP + 8MP + 2MP"
            },
            "reviews": [
                { "user_id": "U010", "username": "BudgetBuyer", "rating": 4, "comment": "Great value for money! Fast charging is amazing.", "date": "2024-02-10" },
                { "user_id": "U025", "username": "StudentTech", "rating": 4, "comment": "Perfect mid-range phone for students.", "date": "2024-03-12" }
            ],
            "tags": ["smartphone", "mid-range", "5G", "android", "fast-charging"],
            "warranty_months": 12,
            "created_at": new Date("2024-01-05T11:00:00Z"),
            "updated_at": new Date("2024-03-25T13:30:00Z")
        },
        {
            "product_id": "ELEC006",
            "name": "Samsung 55-inch QLED TV",
            "category": "Electronics",
            "subcategory": "Televisions",
            "price": 64999.00,
            "stock": 35,
            "specifications": {
                "brand": "Samsung",
                "screen_size": "55 inches",
                "resolution": "3840x2160 (4K)",
                "display_type": "QLED",
                "smart_features": "Tizen OS, Voice Control",
                "refresh_rate": "120Hz"
            },
            "reviews": [
                { "user_id": "U008", "username": "MovieBuff", "rating": 5, "comment": "Picture quality is stunning! Great for movies.", "date": "2024-01-30" },
                { "user_id": "U019", "username": "GamingConsole", "rating": 4, "comment": "Good for PS5 gaming with 120Hz support.", "date": "2024-02-28" }
            ],
            "tags": ["TV", "QLED", "4K", "smart-tv", "120Hz"],
            "warranty_months": 24,
            "created_at": new Date("2023-12-15T09:30:00Z"),
            "updated_at": new Date("2024-03-20T10:00:00Z")
        },
        {
            "product_id": "FASH001",
            "name": "Levi's 511 Slim Fit Jeans",
            "category": "Fashion",
            "subcategory": "Clothing",
            "price": 3499.00,
            "stock": 120,
            "specifications": {
                "brand": "Levi's",
                "material": "98% Cotton, 2% Elastane",
                "fit": "Slim",
                "color": "Dark Blue",
                "sizes_available": ["28", "30", "32", "34", "36", "38"],
                "care": "Machine wash cold"
            },
            "reviews": [
                { "user_id": "U002", "username": "FashionGuy", "rating": 5, "comment": "Perfect fit and very comfortable!", "date": "2024-01-18" },
                { "user_id": "U016", "username": "CasualWear", "rating": 4, "comment": "Good quality jeans, slight fade after few washes.", "date": "2024-02-22" },
                { "user_id": "U027", "username": "DenimLover", "rating": 5, "comment": "Best jeans I've owned. Worth every penny!", "date": "2024-03-15" }
            ],
            "tags": ["jeans", "denim", "casual", "mens-fashion"],
            "warranty_months": 3,
            "created_at": new Date("2023-10-01T08:00:00Z"),
            "updated_at": new Date("2024-03-18T14:20:00Z")
        },
        {
            "product_id": "FASH002",
            "name": "Nike Air Max 270 Sneakers",
            "category": "Fashion",
            "subcategory": "Footwear",
            "price": 12995.00,
            "stock": 85,
            "specifications": {
                "brand": "Nike",
                "type": "Running Shoes",
                "material": "Mesh and Synthetic",
                "color": "Black/White",
                "sizes_available": ["7", "8", "9", "10", "11", "12"],
                "sole": "Air Max cushioning"
            },
            "reviews": [
                { "user_id": "U004", "username": "RunnerLife", "rating": 5, "comment": "Super comfortable for running and daily wear!", "date": "2024-01-22" },
                { "user_id": "U015", "username": "SneakerHead", "rating": 4, "comment": "Great style and comfort, a bit pricey though.", "date": "2024-02-18" }
            ],
            "tags": ["shoes", "sneakers", "running", "athletic", "nike"],
            "warranty_months": 6,
            "created_at": new Date("2023-11-20T10:00:00Z"),
            "updated_at": new Date("2024-03-22T11:30:00Z")
        },
        {
            "product_id": "FASH003",
            "name": "Adidas Originals T-Shirt",
            "category": "Fashion",
            "subcategory": "Clothing",
            "price": 1499.00,
            "stock": 200,
            "specifications": {
                "brand": "Adidas",
                "material": "100% Cotton",
                "fit": "Regular",
                "color": "White with Black Logo",
                "sizes_available": ["S", "M", "L", "XL", "XXL"],
                "sleeve": "Short sleeve"
            },
            "reviews": [
                { "user_id": "U006", "username": "CasualStyle", "rating": 4, "comment": "Good quality t-shirt, comfortable fabric.", "date": "2024-02-05" },
                { "user_id": "U020", "username": "BasicWardrobe", "rating": 5, "comment": "Perfect for everyday wear. Classic design.", "date": "2024-03-08" },
                { "user_id": "U030", "username": "GymRat", "rating": 4, "comment": "Good for workouts, breathable material.", "date": "2024-03-20" }
            ],
            "tags": ["t-shirt", "casual", "cotton", "sportswear"],
            "warranty_months": 3,
            "created_at": new Date("2023-12-10T09:00:00Z"),
            "updated_at": new Date("2024-03-23T15:10:00Z")
        },
        {
            "product_id": "FASH004",
            "name": "Puma RS-X Sneakers",
            "category": "Fashion",
            "subcategory": "Footwear",
            "price": 8999.00,
            "stock": 95,
            "specifications": {
                "brand": "Puma",
                "type": "Casual Sneakers",
                "material": "Leather and Mesh",
                "color": "Multi-color",
                "sizes_available": ["7", "8", "9", "10", "11"],
                "sole": "Rubber with RS cushioning"
            },
            "reviews": [
                { "user_id": "U009", "username": "StreetStyle", "rating": 4, "comment": "Stylish and comfortable, great for casual outings.", "date": "2024-02-12" },
                { "user_id": "U024", "username": "UrbanFashion", "rating": 5, "comment": "Love the retro design! Gets lots of compliments.", "date": "2024-03-16" }
            ],
            "tags": ["sneakers", "casual", "retro", "streetwear"],
            "warranty_months": 6,
            "created_at": new Date("2024-01-08T11:30:00Z"),
            "updated_at": new Date("2024-03-24T12:45:00Z")
        },
        {
            "product_id": "FASH005",
            "name": "H&M Slim Fit Formal Shirt",
            "category": "Fashion",
            "subcategory": "Clothing",
            "price": 1999.00,
            "stock": 150,
            "specifications": {
                "brand": "H&M",
                "material": "Cotton blend",
                "fit": "Slim",
                "color": "Light Blue",
                "sizes_available": ["38", "40", "42", "44", "46"],
                "collar": "Spread collar",
                "sleeve": "Full sleeve"
            },
            "reviews": [
                { "user_id": "U011", "username": "OfficePro", "rating": 4, "comment": "Good quality for the price. Fits well.", "date": "2024-02-08" },
                { "user_id": "U022", "username": "CorporateStyle", "rating": 3, "comment": "Decent shirt but wrinkles easily.", "date": "2024-03-05" }
            ],
            "tags": ["shirt", "formal", "office-wear", "slim-fit"],
            "warranty_months": 3,
            "created_at": new Date("2023-11-25T10:00:00Z"),
            "updated_at": new Date("2024-03-19T13:20:00Z")
        },
        {
            "product_id": "FASH006",
            "name": "Reebok Training Trackpants",
            "category": "Fashion",
            "subcategory": "Clothing",
            "price": 2299.00,
            "stock": 130,
            "specifications": {
                "brand": "Reebok",
                "material": "Polyester",
                "fit": "Regular",
                "color": "Black with White Stripes",
                "sizes_available": ["S", "M", "L", "XL", "XXL"],
                "features": "Elastic waistband, zippered pockets"
            },
            "reviews": [
                { "user_id": "U013", "username": "FitnessFreak", "rating": 5, "comment": "Perfect for gym and jogging. Very comfortable!", "date": "2024-02-15" },
                { "user_id": "U026", "username": "ActiveLifestyle", "rating": 4, "comment": "Good quality, lightweight and breathable.", "date": "2024-03-18" }
            ],
            "tags": ["trackpants", "sportswear", "gym", "athleisure"],
            "warranty_months": 3,
            "created_at": new Date("2023-12-05T09:30:00Z"),
            "updated_at": new Date("2024-03-21T14:50:00Z")
        }
    ];
    
    // Bulk insert all products
    const result = await collection.insertMany(products);
    console.log(`✓ Operation 1 Complete: Loaded ${result.insertedCount} products into '${COLLECTION_NAME}' collection`);
    
    return result;
}


// OPERATION 2: Basic Query


async function queryElectronicsUnder50k(client) {
    const db = client.db(DATABASE_NAME);
    const collection = db.collection(COLLECTION_NAME);
    
    console.log('\n--- Operation 2: Basic Query ---');
    console.log('Finding Electronics products with price < 50000...');
    
    
    const pipeline = [
        
        {
            $match: {
                category: "Electronics",
                price: { $lt: 50000 }
            }
        },
        // Stage 2: Project only required fields
        {
            $project: {
                _id: 0,                      // Exclude _id
                name: 1,                     // Include name
                price: 1,                    // Include price
                stock: 1                     // Include stock
            }
        },
        // Stage 3: Sort by price descending for better readability
        {
            $sort: { price: -1 }
        }
    ];
    
    const results = await collection.aggregate(pipeline).toArray();
    
    console.log(`Found ${results.length} products:\n`);
    results.forEach((product, index) => {
        console.log(`${index + 1}. ${product.name}`);
        console.log(`   Price: ₹${product.price.toLocaleString()}`);
        console.log(`   Stock: ${product.stock} units\n`);
    });
    
    return results;
}


// OPERATION 3: Review Analysis

async function findHighRatedProducts(client) {
    const db = client.db(DATABASE_NAME);
    const collection = db.collection(COLLECTION_NAME);
    
    console.log('\n--- Operation 3: Review Analysis ---');
    console.log('Finding products with average rating >= 4.0...');
    
    
    const pipeline = [
        
        
        {
            $unwind: "$reviews"
        },
        
        {
            $group: {
                _id: "$product_id",
                name: { $first: "$name" },
                category: { $first: "$category" },
                avgRating: { $avg: "$reviews.rating" },
                totalReviews: { $sum: 1 }
            }
        },
        
        {
            $match: {
                avgRating: { $gte: 4.0 }
            }
        },
        // Stage 4: Sort by average rating descending (highest rated first)
        {
            $sort: { avgRating: -1 }
        },
        // Stage 5: Project and format the output
        {
            $project: {
                _id: 1,
                name: 1,
                category: 1,
                avgRating: { $round: ["$avgRating", 2] },
                totalReviews: 1
            }
        }
    ];
    
    const results = await collection.aggregate(pipeline).toArray();
    
    console.log(`Found ${results.length} products with avg rating >= 4.0:\n`);
    results.forEach((product, index) => {
        console.log(`${index + 1}. ${product.name} (${product.category})`);
        console.log(`   Average Rating: ${product.avgRating}/5 ⭐`);
        console.log(`   Total Reviews: ${product.totalReviews}\n`);
    });
    
    return results;
}

// OPERATION 4: Update Operation


async function addReviewToELEC001(client) {
    const db = client.db(DATABASE_NAME);
    const collection = db.collection(COLLECTION_NAME);
    
    console.log('\n--- Operation 4: Update Operation ---');
    console.log('Adding new review to product ELEC001...');
    
    // New review to add
    const newReview = {
        user_id: "U999",
        username: "ValueSeeker",
        rating: 4,
        comment: "Good value for money considering the features offered!",
        date: new Date()
    };
    
    // Update operation using $push to add to reviews array
    const result = await collection.updateOne(
        { product_id: "ELEC001" },
        {
            $push: {
                reviews: newReview
            },
            $set: {
                updated_at: new Date()
            }
        }
    );
    
    console.log(`✓ Updated ${result.modifiedCount} document(s)`);
    
    // Display the updated product with the new review
    const updatedProduct = await collection.findOne(
        { product_id: "ELEC001" },
        {
            projection: {
                _id: 0,
                product_id: 1,
                name: 1,
                reviews: 1,
                updated_at: 1
            }
        }
    );
    
    console.log('\nUpdated Product Details:');
    console.log(`Product: ${updatedProduct.name}`);
    console.log(`Total Reviews: ${updatedProduct.reviews.length}`);
    console.log('\nLatest Review:');
    const latestReview = updatedProduct.reviews[updatedProduct.reviews.length - 1];
    console.log(`  User: ${latestReview.username} (${latestReview.user_id})`);
    console.log(`  Rating: ${latestReview.rating}/5`);
    console.log(`  Comment: "${latestReview.comment}"`);
    console.log(`  Date: ${latestReview.date}`);
    
    return result;
}


// OPERATION 5: Complex Aggregation


async function aggregatePriceByCategory(client) {
    const db = client.db(DATABASE_NAME);
    const collection = db.collection(COLLECTION_NAME);
    
    console.log('\n--- Operation 5: Complex Aggregation ---');
    console.log('Calculating average price by category...');
    
    // Complex aggregation pipeline
    const pipeline = [
        // Stage 1: Group by category and calculate statistics
        {
            $group: {
                _id: "$category",
                avg_price: {
                    $avg: "$price"
                },
                product_count: {
                    $sum: 1
                },
                min_price: {
                    $min: "$price"
                },
                max_price: {
                    $max: "$price"
                },
                total_stock: {
                    $sum: "$stock"
                }
            }
        },
        
        {
            $sort: { avg_price: -1 }
        },
        
        {
            $project: {
                _id: 0,
                category: "$_id",
                avg_price: {
                    $round: ["$avg_price", 2]
                },
                product_count: 1,
                min_price: 1,
                max_price: 1,
                total_stock: 1
            }
        }
    ];
    
    const results = await collection.aggregate(pipeline).toArray();
    
    console.log('\nPrice Analysis by Category:\n');
    console.log('┌─────────────┬──────────────┬───────────────┬────────────┬────────────┬─────────────┐');
    console.log('│ Category    │ Avg Price    │ Product Count │ Min Price  │ Max Price  │ Total Stock │');
    console.log('├─────────────┼──────────────┼───────────────┼────────────┼────────────┼─────────────┤');
    
    results.forEach(category => {
        const row = [
            category.category.padEnd(11),
            `₹${category.avg_price.toLocaleString().padStart(10)}`,
            category.product_count.toString().padStart(13),
            `₹${category.min_price.toLocaleString().padStart(8)}`,
            `₹${category.max_price.toLocaleString().padStart(8)}`,
            category.total_stock.toString().padStart(11)
        ].join('│');
        console.log(`│${row}│`);
    });
    console.log('└─────────────┴──────────────┴───────────────┴────────────┴────────────┴─────────────┘');
    
    // Additional insights
    const totalProducts = results.reduce((sum, r) => sum + r.product_count, 0);
    const overallAvgPrice = results.reduce((sum, r) => sum + (r.avg_price * r.product_count), 0) / totalProducts;
    
    console.log('\nSummary Insights:');
    console.log(`  • Total Categories: ${results.length}`);
    console.log(`  • Total Products: ${totalProducts}`);
    console.log(`  • Overall Average Price: ₹${overallAvgPrice.toFixed(2)}`);
    console.log(`  • Highest Category: ${results[0].category} (₹${results[0].avg_price.toLocaleString()})`);
    console.log(`  • Lowest Category: ${results[results.length - 1].category} (₹${results[results.length - 1].avg_price.toLocaleString()})`);
    
    return results;
}


// MAIN EXECUTION


async function main() {
    console.log('╔════════════════════════════════════════════════════════════╗');
    console.log('║       MongoDB Operations - Product Catalog System          ║');
    console.log('╚════════════════════════════════════════════════════════════╝\n');
    
    let client;
    try {
        // Connect to MongoDB
        client = await connectToMongoDB();
        const db = client.db(DATABASE_NAME);
        
        // Verify collection exists
        const collections = await db.listCollections({ name: COLLECTION_NAME }).toArray();
        if (collections.length === 0) {
            console.log(`! Collection '${COLLECTION_NAME}' does not exist. Creating it...`);
        }
        
        // Execute all operations
        console.log('\n' + '='.repeat(60));
        console.log('EXECUTING ALL OPERATIONS');
        console.log('='.repeat(60));
        
        await loadData(client);
        await queryElectronicsUnder50k(client);
        await findHighRatedProducts(client);
        await addReviewToELEC001(client);
        await aggregatePriceByCategory(client);
        
        console.log('\n' + '='.repeat(60));
        console.log('ALL OPERATIONS COMPLETED SUCCESSFULLY!');
        console.log('='.repeat(60));
        
    } catch (error) {
        console.error('\n✗ Error during execution:', error.message);
        console.error(error.stack);
    } finally {
        
        if (client) {
            await client.close();
            console.log('\n✓ MongoDB connection closed');
        }
    }
}


module.exports = {
    connectToMongoDB,
    loadData,
    queryElectronicsUnder50k,
    findHighRatedProducts,
    addReviewToELEC001,
    aggregatePriceByCategory
};


if (require.main === module) {
    main();
}


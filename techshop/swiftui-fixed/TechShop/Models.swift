import Foundation

struct Product: Identifiable {
    let id: String
    let name: String
    let icon: String
    let price: Int
    let inStock: Bool
}

struct CartItem: Identifiable {
    var id: String { product.id }
    let product: Product
    var quantity: Int
}

// Catalog data. Prices are whole dollars for simple, testable math.
let CATALOG: [Product] = [
    Product(id: "p1", name: "Wireless Headphones", icon: "🎧", price: 60, inStock: true),
    Product(id: "p2", name: "Mechanical Keyboard", icon: "⌨️", price: 90, inStock: true),
    // Deliberately long name — the catalog cell must handle it (BUG-007).
    Product(id: "p3", name: "Ultra-Wide Curved 49-inch Professional Gaming Monitor with HDR", icon: "🖥️", price: 700, inStock: true),
    Product(id: "p4", name: "USB-C Hub", icon: "🔌", price: 40, inStock: false),
]

// Valid discount codes: percentage off the subtotal.
let DISCOUNTS: [String: Int] = ["SAVE10": 10, "SAVE20": 20]

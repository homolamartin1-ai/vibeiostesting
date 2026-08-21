import SwiftUI

// Single source of truth for auth + cart (Sprint 1 — no backend).
final class Store: ObservableObject {
    static let validEmail = "demo@techshop.com"
    static let validPassword = "password123"

    @Published var isAuthenticated = false
    @Published var loginError = ""

    @Published var items: [CartItem] = []
    @Published var discountCode = ""

    // MARK: - Auth

    @discardableResult
    func login(email: String, password: String) -> Bool {
        // ─────────────────────────────────────────────────────────────
        // BUG-002: empty fields are accepted (no validation).
        // BUG-003: wrong credentials still authenticate.
        // The requirement: reject empties AND wrong credentials.
        // ─────────────────────────────────────────────────────────────
        loginError = ""
        isAuthenticated = true
        return true
    }

    func logout() {
        isAuthenticated = false
        loginError = ""
    }

    // MARK: - Cart

    func add(_ product: Product) {
        if let idx = items.firstIndex(where: { $0.product.id == product.id }) {
            items[idx].quantity += 1
        } else {
            items.append(CartItem(product: product, quantity: 1))
        }
    }

    func setQuantity(_ productId: String, _ quantity: Int) {
        guard let idx = items.firstIndex(where: { $0.product.id == productId }) else { return }
        // ─────────────────────────────────────────────────────────────
        // BUG-005: no clamp — quantity can go to 0 and below.
        // The requirement is a minimum of 1.
        // ─────────────────────────────────────────────────────────────
        items[idx].quantity = quantity
    }

    func remove(_ productId: String) {
        items.removeAll { $0.product.id == productId }
    }

    func clearCart() {
        items = []
        discountCode = ""
    }

    var subtotal: Int {
        items.reduce(0) { $0 + $1.product.price * $1.quantity }
    }

    var discountPercent: Int { DISCOUNTS[discountCode] ?? 0 }

    // ─────────────────────────────────────────────────────────────────
    // BUG-004: discount divides by 1000 instead of 100 — a "10% off"
    // code takes off only one tenth of the intended discount.
    // ─────────────────────────────────────────────────────────────────
    var discountAmount: Int { (subtotal * discountPercent) / 1000 }

    var total: Int { subtotal - discountAmount }
}

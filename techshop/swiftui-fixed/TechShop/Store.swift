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

    private func isValidEmail(_ email: String) -> Bool {
        let pattern = "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$"
        return email.range(of: pattern, options: .regularExpression) != nil
    }

    @discardableResult
    func login(email: String, password: String) -> Bool {
        // FIXED (BUG-002): reject empty fields.
        if email.isEmpty || password.isEmpty {
            loginError = "Email and password are required"
            isAuthenticated = false
            return false
        }
        if !isValidEmail(email) {
            loginError = "Enter a valid email address"
            isAuthenticated = false
            return false
        }
        // FIXED (BUG-003): reject wrong credentials.
        if email != Store.validEmail || password != Store.validPassword {
            loginError = "Invalid email or password"
            isAuthenticated = false
            return false
        }
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
        // FIXED (BUG-005): clamp the minimum quantity to 1.
        items[idx].quantity = max(1, quantity)
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

    // FIXED (BUG-004): a percentage discount divides by 100.
    var discountAmount: Int { (subtotal * discountPercent) / 100 }

    var total: Int { subtotal - discountAmount }
}

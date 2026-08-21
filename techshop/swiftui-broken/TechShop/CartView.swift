import SwiftUI

struct CartView: View {
    @EnvironmentObject var store: Store
    @State private var displayedTotal = 0
    @State private var message = ""

    private let minOrder = 10

    var body: some View {
        NavigationStack {
            Group {
                if store.items.isEmpty {
                    Text("Your cart is empty")
                        .foregroundColor(.gray)
                        .accessibilityIdentifier("cart-empty")
                } else {
                    List {
                        ForEach(store.items) { item in
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(item.product.name).fontWeight(.semibold)
                                    Text("$\(item.product.price) each")
                                        .font(.caption).foregroundColor(.gray)
                                    Text("Line: $\(item.product.price * item.quantity)")
                                        .font(.caption)
                                        .foregroundColor(Color(red: 0.23, green: 0.18, blue: 0.71))
                                        .accessibilityIdentifier("line-total-\(item.product.id)")
                                }
                                Spacer()
                                Button("−") { store.setQuantity(item.product.id, item.quantity - 1) }
                                    .buttonStyle(.bordered)
                                    .accessibilityIdentifier("qty-decrement-\(item.product.id)")
                                Text("\(item.quantity)")
                                    .frame(minWidth: 24)
                                    .accessibilityIdentifier("qty-\(item.product.id)")
                                Button("+") { store.setQuantity(item.product.id, item.quantity + 1) }
                                    .buttonStyle(.bordered)
                                    .accessibilityIdentifier("qty-increment-\(item.product.id)")
                            }
                        }

                        TextField("Discount code", text: $store.discountCode)
                            .textInputAutocapitalization(.characters)
                            .accessibilityIdentifier("discount-input")

                        Text("Subtotal: $\(store.subtotal)")
                        // ─────────────────────────────────────────────
                        // BUG-006: shows `displayedTotal`, which is only
                        // refreshed when the item COUNT changes (below),
                        // not when a quantity changes. Tapping + / − does
                        // not update this. Fix: show `store.total`.
                        // ─────────────────────────────────────────────
                        Text("Order Total: $\(displayedTotal)")
                            .font(.title3).bold()
                            .accessibilityIdentifier("order-total")

                        if !message.isEmpty {
                            Text(message).foregroundColor(.red)
                                .accessibilityIdentifier("cart-message")
                        }

                        Button {
                            proceed()
                        } label: {
                            Text("Proceed to Checkout")
                                .fontWeight(.bold).foregroundColor(.white)
                                .frame(maxWidth: .infinity).padding()
                                .background(Color(red: 0.23, green: 0.18, blue: 0.71))
                                .cornerRadius(10)
                        }
                        .accessibilityIdentifier("proceed-checkout")
                    }
                }
            }
            .navigationTitle("Cart")
        }
        .onAppear { displayedTotal = store.total }
        // BUG-006: only reacts to a change in the number of line items.
        .onChange(of: store.items.count) { _ in displayedTotal = store.total }
    }

    private func proceed() {
        if displayedTotal < minOrder {
            message = "Minimum order value is $\(minOrder).00"
            return
        }
        message = ""
        // ─────────────────────────────────────────────────────────────
        // BUG-011: no-op. "Proceed to Checkout" does not navigate.
        // The fix is to push CheckoutView.
        // ─────────────────────────────────────────────────────────────
    }
}

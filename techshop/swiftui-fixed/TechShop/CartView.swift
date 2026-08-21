import SwiftUI

struct CartView: View {
    @EnvironmentObject var store: Store
    @State private var message = ""
    @State private var goToCheckout = false

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
                        // FIXED (BUG-006): show the live total directly.
                        Text("Order Total: $\(store.total)")
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
            // FIXED (BUG-011): navigate to Checkout.
            .navigationDestination(isPresented: $goToCheckout) {
                CheckoutView()
            }
        }
    }

    private func proceed() {
        // FIXED (BUG-006): validates against the live total.
        if store.total < minOrder {
            message = "Minimum order value is $\(minOrder).00"
            return
        }
        message = ""
        goToCheckout = true
    }
}

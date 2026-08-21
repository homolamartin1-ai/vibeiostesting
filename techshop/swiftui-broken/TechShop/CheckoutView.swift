import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var store: Store
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var card = ""
    @State private var expiry = ""
    @State private var cvv = ""
    @State private var orderRef: String?

    var body: some View {
        // ─────────────────────────────────────────────────────────────
        // BUG-017: a fixed VStack (not a ScrollView) means the software
        // keyboard covers the CVV field near the bottom, and it cannot
        // scroll into view. The fix is to use a ScrollView / Form.
        // ─────────────────────────────────────────────────────────────
        VStack(spacing: 10) {
            Text("Checkout").font(.title2).bold()

            field("First Name", $firstName, id: "firstName")
            field("Last Name", $lastName, id: "lastName")
            field("Email", $email, id: "email", keyboard: .emailAddress)
            field("Phone", $phone, id: "phone", keyboard: .numberPad)
            field("Card Number", $card, id: "card", keyboard: .numberPad)
            field("Expiry (MM/YY)", $expiry, id: "expiry")
            // ─────────────────────────────────────────────────────────
            // BUG-010: CVV uses the default keyboard, so letters/symbols
            // are accepted. The spec requires the numeric keypad.
            // ─────────────────────────────────────────────────────────
            field("CVV", $cvv, id: "cvv")

            Button {
                submit()
            } label: {
                Text("Place Order")
                    .fontWeight(.bold).foregroundColor(.white)
                    .frame(maxWidth: .infinity).padding()
                    .background(Color(red: 0.23, green: 0.18, blue: 0.71))
                    .cornerRadius(10)
            }
            .accessibilityIdentifier("checkout-submit")

            Spacer()
        }
        .padding()
        .navigationDestination(isPresented: Binding(
            get: { orderRef != nil },
            set: { if !$0 { orderRef = nil } }
        )) {
            ConfirmationView(orderRef: orderRef, total: store.total)
        }
    }

    private func field(_ label: String, _ text: Binding<String>, id: String,
                       keyboard: UIKeyboardType = .default) -> some View {
        TextField(label, text: text)
            .keyboardType(keyboard)
            .textInputAutocapitalization(.never)
            .textFieldStyle(.roundedBorder)
            .accessibilityIdentifier("checkout-\(id)")
    }

    private func submit() {
        // ───────────────────────────────────────────────────────────────
        // BUG-012: no validation — submits with any/all fields empty.
        // BUG-009: expiry is never checked, so past dates are accepted.
        // BUG-010: CVV is never checked for 3 numeric digits.
        // ───────────────────────────────────────────────────────────────
        orderRef = "TS-\(Int.random(in: 100000...999999))"
        store.clearCart()
    }
}

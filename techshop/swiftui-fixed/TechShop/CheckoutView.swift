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
    @State private var error = ""
    @State private var orderRef: String?

    var body: some View {
        // FIXED (BUG-017): a ScrollView keeps the focused field (including
        // CVV at the bottom) visible above the software keyboard.
        ScrollView {
            VStack(spacing: 10) {
                Text("Checkout").font(.title2).bold()

                field("First Name", $firstName, id: "firstName")
                field("Last Name", $lastName, id: "lastName")
                field("Email", $email, id: "email", keyboard: .emailAddress)
                field("Phone", $phone, id: "phone", keyboard: .numberPad)
                field("Card Number", $card, id: "card", keyboard: .numberPad)
                field("Expiry (MM/YY)", $expiry, id: "expiry")
                // FIXED (BUG-010): CVV uses the numeric keypad.
                field("CVV", $cvv, id: "cvv", keyboard: .numberPad)

                if !error.isEmpty {
                    Text(error).foregroundColor(.red)
                        .accessibilityIdentifier("checkout-error")
                }

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
            }
            .padding()
        }
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

    private func matches(_ value: String, _ pattern: String) -> Bool {
        value.range(of: pattern, options: .regularExpression) != nil
    }

    private func isExpiryInPast(_ mmYY: String) -> Bool {
        guard matches(mmYY, "^\\d{2}/\\d{2}$") else { return true }
        let parts = mmYY.split(separator: "/")
        guard let month = Int(parts[0]), let yy = Int(parts[1]), (1...12).contains(month) else {
            return true
        }
        var comps = DateComponents()
        comps.year = 2000 + yy
        comps.month = month + 1
        comps.day = 1
        let cal = Calendar.current
        guard let firstOfNextMonth = cal.date(from: comps),
              let endOfExpiry = cal.date(byAdding: .day, value: -1, to: firstOfNextMonth) else {
            return true
        }
        return endOfExpiry < Date()
    }

    private func submit() {
        // FIXED (BUG-012): every field required.
        let required = [firstName, lastName, email, phone, card, expiry, cvv]
        if required.contains(where: { $0.trimmingCharacters(in: .whitespaces).isEmpty }) {
            error = "All fields are required"
            return
        }
        if !matches(email, "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$") { error = "Enter a valid email"; return }
        if !matches(phone, "^\\d{10}$") { error = "Phone must be 10 digits"; return }
        if !matches(card, "^\\d{16}$") { error = "Card number must be 16 digits"; return }
        // FIXED (BUG-009): reject past expiry dates.
        if isExpiryInPast(expiry) { error = "Expiry date must not be in the past"; return }
        // FIXED (BUG-010): CVV must be exactly 3 digits.
        if !matches(cvv, "^\\d{3}$") { error = "CVV must be 3 digits"; return }

        error = ""
        orderRef = "TS-\(Int.random(in: 100000...999999))"
        store.clearCart()
    }
}

import SwiftUI

struct ConfirmationView: View {
    let orderRef: String?
    let total: Int

    var body: some View {
        VStack(spacing: 12) {
            Text("✓").font(.system(size: 56)).foregroundColor(.green)
            Text("Order Confirmed")
                .font(.title).bold()
                .accessibilityIdentifier("confirmation-title")

            // ─────────────────────────────────────────────────────────
            // BUG-013: the order reference is NOT shown. The value exists
            // in `orderRef` — it is simply never rendered. The spec
            // requires it so the customer can track the order.
            // ─────────────────────────────────────────────────────────

            Text("Total Paid: $\(total)")
                .foregroundColor(Color(red: 0.23, green: 0.18, blue: 0.71))
                .fontWeight(.bold)
                .accessibilityIdentifier("confirmation-total")
            Text("Thank you for shopping with TechShop.")
                .font(.footnote).foregroundColor(.gray)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

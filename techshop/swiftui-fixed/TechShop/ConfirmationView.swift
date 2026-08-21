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

            // FIXED (BUG-013): the order reference is displayed.
            Text("Order Reference: \(orderRef ?? "")")
                .fontWeight(.semibold)
                .accessibilityIdentifier("confirmation-order-ref")

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

import SwiftUI

struct CatalogView: View {
    @EnvironmentObject var store: Store

    var body: some View {
        NavigationStack {
            List(CATALOG) { product in
                HStack(spacing: 14) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(red: 0.90, green: 0.89, blue: 0.96))
                        .frame(width: 52, height: 52)
                        .overlay(Text(product.icon).font(.system(size: 28)))

                    VStack(alignment: .leading, spacing: 2) {
                        // FIXED (BUG-007): clamp to one line with an ellipsis.
                        Text(product.name)
                            .font(.system(size: 16, weight: .semibold))
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .accessibilityIdentifier("product-name-\(product.id)")
                        Text("$\(product.price)")
                            .foregroundColor(Color(red: 0.23, green: 0.18, blue: 0.71))

                        if !product.inStock {
                            // FIXED (BUG-008): the badge is red.
                            Text("Out of Stock")
                                .font(.caption).bold()
                                .foregroundColor(.red)
                                .accessibilityIdentifier("badge-\(product.id)")
                        }
                    }

                    Spacer()

                    Button("Add") { store.add(product) }
                        .buttonStyle(.borderedProminent)
                        .disabled(!product.inStock)
                        .accessibilityIdentifier("add-\(product.id)")
                }
                .padding(.vertical, 4)
            }
            // FIXED (BUG-014): the navigation title is "Products".
            .navigationTitle("Products")
        }
    }
}

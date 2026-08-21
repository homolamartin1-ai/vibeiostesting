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
                        // ─────────────────────────────────────────────
                        // BUG-007: no lineLimit — a long product name
                        // wraps and disrupts the cell layout. The fix is
                        // .lineLimit(1).truncationMode(.tail).
                        // ─────────────────────────────────────────────
                        Text(product.name)
                            .font(.system(size: 16, weight: .semibold))
                            .accessibilityIdentifier("product-name-\(product.id)")
                        Text("$\(product.price)")
                            .foregroundColor(Color(red: 0.23, green: 0.18, blue: 0.71))

                        if !product.inStock {
                            // ─────────────────────────────────────────
                            // BUG-008: "Out of Stock" badge is green.
                            // It should be red.
                            // ─────────────────────────────────────────
                            Text("Out of Stock")
                                .font(.caption).bold()
                                .foregroundColor(.green)
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
            // ─────────────────────────────────────────────────────────
            // BUG-014: the navigation title is "Untitled" not "Products".
            // ─────────────────────────────────────────────────────────
            .navigationTitle("Untitled")
        }
    }
}

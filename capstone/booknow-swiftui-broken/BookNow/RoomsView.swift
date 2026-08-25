import SwiftUI

struct RoomsView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        NavigationStack(path: $store.navigationPath) {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(store.rooms) { room in
                        RoomCardView(room: room) {
                            store.selectRoom(room)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Available Rooms")
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .booking(let room):
                    BookingView(room: room)
                case .confirmation:
                    if let booking = store.currentBooking {
                        ConfirmationView(booking: booking)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { store.logout() }) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundStyle(.red)
                    }
                    .accessibilityIdentifier("logout-btn")
                }
            }
        }
    }
}

struct RoomCardView: View {
    let room: Room
    let onSelect: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
                    .frame(height: 160)
                    .overlay(
                        Image(systemName: room.systemImage)
                            .font(.system(size: 50))
                            .foregroundStyle(.blue.opacity(0.8))
                    )
                
                // BUG-008: Available badge displays in red
                Text("Available")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.red.opacity(0.9))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(10)
                    .accessibilityIdentifier("badge-available-\(room.id)")
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(room.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .accessibilityIdentifier("room-name-\(room.id)")
                
                Text(room.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
                    .accessibilityIdentifier("room-desc-\(room.id)")
                
                HStack(alignment: .firstTextBaseline) {
                    Text(room.formattedOriginalPrice)
                        .font(.subheadline)
                        .strikethrough()
                        .foregroundStyle(.secondary)
                    
                    Text(room.formattedDiscountedPrice + "/night")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.blue)
                        .accessibilityIdentifier("room-price-\(room.id)")
                    
                    Spacer()
                    
                    Text("\(Int(room.discount))% OFF")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Color.orange.opacity(0.2))
                        .foregroundColor(.orange)
                        .cornerRadius(6)
                }
                .padding(.top, 4)
                
                Button(action: onSelect) {
                    Text("Select Room")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 8)
                .accessibilityIdentifier("btn-select-room-\(room.id)")
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
        .accessibilityIdentifier("room-card-\(room.id)")
    }
}

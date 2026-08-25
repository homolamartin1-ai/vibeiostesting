import SwiftUI

struct ConfirmationView: View {
    let booking: Booking
    @EnvironmentObject var store: Store
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 12) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 70))
                        .foregroundStyle(.green)
                        .accessibilityIdentifier("confirm-icon")
                    
                    Text("Booking Confirmed!")
                        .font(.title)
                        .fontWeight(.bold)
                        .accessibilityIdentifier("confirm-title")
                    
                    Text("Thank you for choosing BookNow. Your reservation has been secured.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 14) {
                    HStack {
                        Text("Reference Number")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(booking.referenceNumber)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.blue)
                            .accessibilityIdentifier("confirm-ref")
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Guest Name")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(booking.fullName)
                            .fontWeight(.medium)
                            .accessibilityIdentifier("confirm-name")
                    }
                    
                    HStack {
                        Text("Room")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(booking.room.name)
                            .fontWeight(.medium)
                            .accessibilityIdentifier("confirm-room")
                    }
                    
                    HStack {
                        Text("Check-in")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(dateFormatter.string(from: booking.checkInDate))
                    }
                    
                    HStack {
                        Text("Check-out")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(dateFormatter.string(from: booking.checkOutDate))
                    }
                    
                    HStack {
                        Text("Guests")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("\(booking.guests)")
                    }
                    
                    HStack {
                        Text("Duration")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("\(booking.nights) night\(booking.nights == 1 ? "" : "s")")
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Total Charged")
                            .font(.headline)
                        Spacer()
                        Text(booking.formattedTotal)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.green)
                            .accessibilityIdentifier("confirm-total")
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                
                Button(action: {
                    store.resetToRooms()
                }) {
                    Text("Back to Rooms")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .accessibilityIdentifier("btn-done")
                .padding(.top, 10)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

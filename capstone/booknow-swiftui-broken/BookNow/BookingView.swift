import SwiftUI

struct BookingView: View {
    let room: Room
    @EnvironmentObject var store: Store
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var checkInDate: Date = Date()
    @State private var checkOutDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    @State private var guests: Int = 1
    
    // BUG-011: Frozen at 1 night
    var nights: Int {
        return 1
    }
    
    var totalPrice: Double {
        return room.discountedPrice * Double(nights)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Room Header
                VStack(alignment: .leading, spacing: 6) {
                    Text(room.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .accessibilityIdentifier("booking-room-name")
                    
                    Text("\(room.formattedDiscountedPrice) / night")
                        .font(.subheadline)
                        .foregroundStyle(.blue)
                        .fontWeight(.semibold)
                        .accessibilityIdentifier("booking-room-price")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Guest Information
                VStack(alignment: .leading, spacing: 14) {
                    Text("Guest Information")
                        .font(.headline)
                    
                    HStack(spacing: 12) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("First Name")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            TextField("First Name", text: $firstName)
                                .textFieldStyle(.roundedBorder)
                                .accessibilityIdentifier("book-fname")
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Last Name")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            TextField("Last Name", text: $lastName)
                                .textFieldStyle(.roundedBorder)
                                .accessibilityIdentifier("book-lname")
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Email Address")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        TextField("Email Address", text: $email)
                            .textFieldStyle(.roundedBorder)
                            .accessibilityIdentifier("book-email")
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Phone Number")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        TextField("Phone Number", text: $phone)
                            .textFieldStyle(.roundedBorder)
                            .accessibilityIdentifier("book-phone")
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 2)
                
                // Dates & Guests
                VStack(alignment: .leading, spacing: 14) {
                    Text("Stay Details")
                        .font(.headline)
                    
                    DatePicker("Check-in Date", selection: $checkInDate, displayedComponents: .date)
                        .accessibilityIdentifier("book-checkin")
                    
                    // BUG-009: Allows checkout before checkin
                    DatePicker("Check-out Date", selection: $checkOutDate, displayedComponents: .date)
                        .accessibilityIdentifier("book-checkout")
                    
                    // BUG-010: Guests can be 0 or negative
                    Stepper("Guests: \(guests)", value: $guests, in: -5...10)
                        .accessibilityIdentifier("book-guests")
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 2)
                
                // Summary Panel
                VStack(alignment: .leading, spacing: 10) {
                    Text("Booking Summary")
                        .font(.headline)
                    
                    Divider()
                    
                    HStack {
                        Text("Price per night")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(room.formattedDiscountedPrice)
                    }
                    
                    HStack {
                        Text("Nights")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("\(nights)")
                            .accessibilityIdentifier("summary-nights")
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Estimated Total")
                            .font(.headline)
                        Spacer()
                        Text(String(format: "$%.2f", totalPrice))
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.blue)
                            .accessibilityIdentifier("summary-total")
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // BUG-012: Submits unconditionally
                Button(action: handleBooking) {
                    Text("Confirm & Book Now")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .accessibilityIdentifier("btn-book-now")
                .padding(.bottom, 20)
            }
            .padding()
        }
        .navigationTitle("Complete Booking")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func handleBooking() {
        _ = store.createBooking(
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            guests: guests
        )
    }
}

import SwiftUI

struct ConfirmationView: View {
    let booking: Booking
    @EnvironmentObject var store: Store
    
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
                    
                    // BUG-015: Generic message with no booking summary
                    Text("Thank you for choosing BookNow.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.top, 20)
                
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
                .padding(.top, 20)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

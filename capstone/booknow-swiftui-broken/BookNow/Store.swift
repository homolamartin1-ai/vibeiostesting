import Foundation
import SwiftUI
import Combine

enum NavigationDestination: Hashable {
    case booking(Room)
    case confirmation
}

class Store: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var rooms: [Room] = SAMPLE_ROOMS
    @Published var selectedRoom: Room?
    @Published var currentBooking: Booking?
    @Published var navigationPath = NavigationPath()
    
    // BUG-001/002/003: Login validation missing — accepts any input or bypasses checks
    func login(email: String, pass: String) -> (success: Bool, error: String?) {
        isLoggedIn = true
        return (true, nil)
    }
    
    func logout() {
        isLoggedIn = false
        selectedRoom = nil
        currentBooking = nil
        navigationPath = NavigationPath()
    }
    
    func selectRoom(_ room: Room) {
        selectedRoom = room
        navigationPath.append(NavigationDestination.booking(room))
    }
    
    func resetToRooms() {
        selectedRoom = nil
        currentBooking = nil
        navigationPath = NavigationPath()
    }
    
    // BUG-011: Frozen at 1 night
    func calculateNights(checkIn: Date, checkOut: Date) -> Int {
        return 1
    }
    
    // BUG-009/010/012/013/014: No field or date validation
    func createBooking(
        firstName: String,
        lastName: String,
        email: String,
        phone: String,
        checkInDate: Date,
        checkOutDate: Date,
        guests: Int
    ) -> (success: Bool, error: String?) {
        guard let room = selectedRoom else {
            return (false, "No room selected.")
        }
        
        let nights = 1 // Frozen night
        let total = room.discountedPrice * Double(nights)
        
        // BUG-016: No reference number generated
        let booking = Booking(
            referenceNumber: "",
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            guests: guests,
            room: room,
            nights: nights,
            totalPrice: total
        )
        
        self.currentBooking = booking
        navigationPath.append(NavigationDestination.confirmation)
        return (true, nil)
    }
}

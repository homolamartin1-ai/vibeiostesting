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
    
    func login(email: String, pass: String) -> (success: Bool, error: String?) {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedEmail.isEmpty || pass.isEmpty {
            return (false, "Please enter your email address and password.")
        }
        if trimmedEmail != "guest@booknow.com" || pass != "stay2026" {
            return (false, "Incorrect email or password. Please try again.")
        }
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
    
    func calculateNights(checkIn: Date, checkOut: Date) -> Int {
        let calendar = Calendar.current
        let startOfIn = calendar.startOfDay(for: checkIn)
        let startOfOut = calendar.startOfDay(for: checkOut)
        let components = calendar.dateComponents([.day], from: startOfIn, to: startOfOut)
        return max(0, components.day ?? 0)
    }
    
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
        
        let trimmedFirst = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedLast = lastName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPhone = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedFirst.isEmpty {
            return (false, "First name is required.")
        }
        if trimmedLast.isEmpty {
            return (false, "Last name is required.")
        }
        
        let emailRegex = #"^[^\s@]+@[^\s@]+\.[^\s@]+$"#
        if trimmedEmail.range(of: emailRegex, options: .regularExpression) == nil {
            return (false, "Please enter a valid email address.")
        }
        
        let phoneRegex = #"^[0-9 +\-().]{7,}$"#
        if trimmedPhone.range(of: phoneRegex, options: .regularExpression) == nil {
            return (false, "Please enter a valid phone number.")
        }
        
        let nights = calculateNights(checkIn: checkInDate, checkOut: checkOutDate)
        if nights <= 0 {
            return (false, "Check-out date must be after check-in date.")
        }
        
        if guests < 1 {
            return (false, "Number of guests must be at least 1.")
        }
        
        let total = room.discountedPrice * Double(nights)
        let refNumber = "BKN-\(Int.random(in: 100000...999999))"
        
        let booking = Booking(
            referenceNumber: refNumber,
            firstName: trimmedFirst,
            lastName: trimmedLast,
            email: trimmedEmail,
            phone: trimmedPhone,
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

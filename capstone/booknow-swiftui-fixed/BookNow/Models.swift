import Foundation

struct Room: Identifiable, Hashable {
    let id: Int
    let name: String
    let description: String
    let price: Double
    let discount: Double
    let systemImage: String
    
    var discountedPrice: Double {
        return price * (1.0 - (discount / 100.0))
    }
    
    var formattedOriginalPrice: String {
        return String(format: "$%.2f", price)
    }
    
    var formattedDiscountedPrice: String {
        return String(format: "$%.2f", discountedPrice)
    }
}

struct Booking: Identifiable {
    let id = UUID()
    let referenceNumber: String
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    let checkInDate: Date
    let checkOutDate: Date
    let guests: Int
    let room: Room
    let nights: Int
    let totalPrice: Double
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    var formattedTotal: String {
        return String(format: "$%.2f", totalPrice)
    }
}

let SAMPLE_ROOMS: [Room] = [
    Room(
        id: 1,
        name: "Deluxe Room",
        description: "Comfortable room with king-size bed, city view, and complimentary breakfast included.",
        price: 129.0,
        discount: 20.0,
        systemImage: "bed.double.fill"
    ),
    Room(
        id: 2,
        name: "Superior Room",
        description: "Spacious room with twin beds, garden view, and access to the rooftop pool.",
        price: 89.0,
        discount: 10.0,
        systemImage: "house.fill"
    ),
    Room(
        id: 3,
        name: "Family Suite",
        description: "Generous family suite with two bedrooms, a spacious living area, kitchenette, and ocean views.",
        price: 199.0,
        discount: 15.0,
        systemImage: "building.2.fill"
    ),
    Room(
        id: 4,
        name: "Penthouse Suite",
        description: "Exclusive top-floor suite with private terrace, butler service, and panoramic skyline views.",
        price: 299.0,
        discount: 5.0,
        systemImage: "crown.fill"
    )
]

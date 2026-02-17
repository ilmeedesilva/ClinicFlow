import Foundation

enum ServiceType {
    case doctor
    case laboratory
    case pharmacy
}

struct BookableItem {
    let serviceType: ServiceType
    let title: String
    let subtitle: String
    let price: Double
    let image: String
}

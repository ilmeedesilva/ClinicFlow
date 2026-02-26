import Foundation

struct Country: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let isoCode: String
    let dialCode: String
    
    var flag: String {
        isoCode
            .unicodeScalars
            .compactMap { UnicodeScalar(127397 + $0.value) }
            .map { String($0) }
            .joined()
    }
}

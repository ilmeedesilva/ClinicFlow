import SwiftUI

struct FamilyMember: Identifiable, Equatable {
    
    let id: UUID
    var name: String
    var age: Int
    var gender: String
    var contact: String
    var relationship: String
    var image: String
    
    init(
        id: UUID = UUID(),
        name: String,
        age: Int,
        gender: String,
        contact: String,
        relationship: String,
        image: String = "person.circle.fill"
    ) {
        self.id = id
        self.name = name
        self.age = age
        self.gender = gender
        self.contact = contact
        self.relationship = relationship
        self.image = image
    }
}

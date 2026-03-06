import Foundation

struct AppointmentDetails {
    let queueNumber: Int
    let room: String
    let dateTime: String
}

struct Appointment: Identifiable {
    let id = UUID()
    let doctorName: String
    let specialty: String
    let image: String
    let date: String
    let time: String
    var status: AppointmentStatus
}

enum AppointmentStatus {
    case inProgress
    case completed
}

import SwiftUI
internal import Combine

class AppState: ObservableObject {
    @Published var hasActiveAppointment: Bool = false
    @Published var queueNumber: Int = 13
    @Published var currentAppointment: AppointmentDetails?
    @Published var currentItem: BookableItem?
        @Published var currentStage: QueueStage = .awaiting
}

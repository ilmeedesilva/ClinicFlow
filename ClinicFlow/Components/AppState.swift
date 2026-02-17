import SwiftUI
internal import Combine

class AppState: ObservableObject {
    @Published var hasActiveAppointment: Bool = false
    @Published var queueNumber: Int = 13
}

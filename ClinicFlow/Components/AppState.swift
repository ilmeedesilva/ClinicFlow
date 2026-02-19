import SwiftUI
import Combine

enum AppointmentStage {
    case awaiting
    case yourTurn
    case completed
}

// MARK: Notification Model
struct AppNotification: Identifiable {
    let id = UUID()
    let type: NotificationType
    let title: String
    let message: String
    let date: Date
}

enum NotificationType {
    case consultationReady
    case yourTurn
    case labReady
    case pharmacyReady
    case waitingUpdated
}


class AppState: ObservableObject {
    
    // MARK: Appointment State
    @Published var hasActiveAppointment: Bool = false
    @Published var queueNumber: Int = 0
    @Published var currentItem: BookableItem?
    @Published var currentStage: AppointmentStage = .awaiting
    
    @Published var selectedNotification: AppNotification?
    
    // MARK: Pharmacy Navigation
    @Published var shouldNavigateToPharmacyPayment = false
    
    // MARK: Notifications
    @Published var notifications: [AppNotification] = []
    
    // MARK: Create Appointment
    func createAppointment(for item: BookableItem) {
        
        currentItem = item
        queueNumber = Int.random(in: 5...20)
        currentStage = .awaiting
        hasActiveAppointment = true
        
        addNotification(
            type: .waitingUpdated,
            title: "Appointment Confirmed",
            message: "Your queue number is \(queueNumber)"
        )
    }
    
    // MARK: Move To Next Stage
    func moveToNextStage() {
        
        switch currentStage {
        case .awaiting:
            currentStage = .yourTurn
            
            if let item = currentItem {
                addNotification(
                    type: .yourTurn,
                    title: "It’s Your Turn",
                    message: "Please proceed to \(item.floor), \(item.room)"
                )
            }
            
        case .yourTurn:
            currentStage = .completed
            
            if let item = currentItem {
                addNotification(
                    type: notificationType(for: item.serviceType),
                    title: completionTitle(for: item.serviceType),
                    message: "Service completed successfully."
                )
            }
            
        case .completed:
            break
        }
    }
    
    // MARK: Completion Title
    private func completionTitle(for type: ServiceType) -> String {
        switch type {
        case .doctor: return "Consultation Completed"
        case .laboratory: return "Laboratory Service Completed"
        case .pharmacy: return "Medicine Collection Completed"
        }
    }
    
    // MARK: Reset
    func resetAppointment() {
        hasActiveAppointment = false
        currentItem = nil
        currentStage = .awaiting
        queueNumber = 0
    }
    
    // MARK: Notifications
    func addNotification(type: NotificationType, title: String, message: String) {
        notifications.insert(
            AppNotification(
                type: type,
                title: title,
                message: message,
                date: Date()
            ),
            at: 0
        )
    }
    
    private func notificationType(for type: ServiceType) -> NotificationType {
        switch type {
        case .doctor: return .consultationReady
        case .laboratory: return .labReady
        case .pharmacy: return .pharmacyReady
        }
    }


}

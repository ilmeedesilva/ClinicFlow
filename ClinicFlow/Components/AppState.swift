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
    
    @Published var shouldReturnToHome: Bool = false
    
    @Published var selectedPatient: FamilyMember?
    
    // MARK: Pharmacy Navigation
    @Published var shouldNavigateToPharmacyPayment = false
    
    // MARK: Notifications
    @Published var notifications: [AppNotification] = []
    
    // MARK: Authentication
    @Published var isLoggedIn: Bool = false
    @Published var otpCode: String = ""
    
    @Published var selectedTab: Int = 0
    
    @Published var familyMembers: [FamilyMember] = [
            FamilyMember(
                name: "John Dae",
                age: 30,
                gender: "Male",
                contact: "0712345678",
                relationship: "You"
            ),
            FamilyMember(
                name: "Kamal Silva",
                age: 55,
                gender: "Male",
                contact: "0771234567",
                relationship: "Father"
            ),
            FamilyMember(
                name: "Amila Silva",
                age: 52,
                gender: "Female",
                contact: "0769876543",
                relationship: "Mother"
            )
        ]
        
        func addFamilyMember(_ member: FamilyMember) {
            familyMembers.append(member)
        }
        
        func updateFamilyMember(_ updated: FamilyMember) {
            if let index = familyMembers.firstIndex(where: { $0.id == updated.id }) {
                familyMembers[index] = updated
            }
        }

    func sendOTP(to phone: String) {
        otpCode = "123456"
    }

    func verifyOTP(_ input: String) -> Bool {
        return input == otpCode
    }

    func logout() {
        isLoggedIn = false
    }
    
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

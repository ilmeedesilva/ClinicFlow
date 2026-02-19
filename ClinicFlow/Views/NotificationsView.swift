import SwiftUI

struct NotificationsView: View {
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            AppHeader(title: "Notifications")
            
            ScrollView {
                
                VStack(spacing: 8) {
                    
                    ForEach(appState.notifications) { notification in
                        
                        Button {
                            handleTap(notification)
                        } label: {
                            
                            HStack(spacing: 12) {
                                
                                Image(icon(for: notification.type))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 36, height: 36)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(notification.title)
                                        .fontWeight(.semibold)
                                    
                                    Text(notification.message)
                                        .font(.caption)
                                }
                                
                                Spacer()
                            }
                            .padding()
                            .background(Color(hex: "#CFE0CD"))
                            .cornerRadius(12)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
    
    func icon(for type: NotificationType) -> String {
        switch type {
        case .consultationReady:
            return "homecard-docimg"
        case .yourTurn:
            return "queueimg"
        case .labReady:
            return "homecard-labimg"
        case .pharmacyReady:
            return "homecard-pharmacyimg"
        case .waitingUpdated:
            return "clock"
        }
    }
    
    func handleTap(_ notification: AppNotification) {
        
        switch notification.type {
            
        case .consultationReady,
             .yourTurn,
             .labReady:
            
            appState.hasActiveAppointment = true
            
        case .pharmacyReady:
            
            appState.hasActiveAppointment = true
            appState.shouldNavigateToPharmacyPayment = true
            
        case .waitingUpdated:
            break
        }
    }
}


#Preview {
    let state = AppState()
    state.createAppointment(for:
        BookableItem(
            serviceType: .doctor,
            title: "Dr. Patricia",
            subtitle: "ENT",
            price: 2500,
            image: "doctor1",
            room: "Room 204",
            floor: "Ground Floor"
        )
    )
    
    return NotificationsView()
        .environmentObject(state)
}

import SwiftUI

struct NotificationsView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: Header
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Text("Notifications")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.left").opacity(0)
            }
            .padding()
            .background(Color(red: 0.18, green: 0.41, blue: 0.45))
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                
                    Text("Notifications")
                        .font(.headline)
                        .bold()
                        .padding()
                    
                    ForEach(appState.notifications) { notification in
                        Button {
                            handleTap(notification)
                        } label: {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(notification.title)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text(notification.message)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                                
                                Divider()
                                    .padding(.top, 10)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                            .background(Color.white)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    func handleTap(_ notification: AppNotification) {
        switch notification.type {
        case .consultationReady, .yourTurn, .labReady:
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
    
    state.addNotification(
        type: .consultationReady,
        title: "Laboratory Appointment",
        message: "Your laboratory appointment booked from the portal"
    )
    state.addNotification(
        type: .consultationReady,
        title: "Follow-up consultation appointment",
        message: "Your follow-up consultation doctor appointment booked"
    )
    state.addNotification(
        type: .consultationReady,
        title: "Consultation ready",
        message: "Please proceed to Consultation Room 204."
    )
    state.addNotification(
        type: .yourTurn,
        title: "It's your turn now",
        message: "Please proceed to the consultation room."
    )
    
   
    
    return NotificationsView()
        .environmentObject(state)
}

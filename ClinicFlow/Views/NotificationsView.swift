import SwiftUI

struct NotificationsView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {

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
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text("Notifications")
                        .font(.headline)
                        .bold()
                        .padding(.horizontal)
                        .padding(.top)
                    
                    ForEach(appState.notifications) { notification in
                        
                        Button {
                            handleTap(notification)
                        } label: {
                            
                            HStack(alignment: .top, spacing: 12) {
                                
                                ZStack {
                                    Circle()
                                        .fill(iconColor(for: notification.type).opacity(0.15))
                                        .frame(width: 42, height: 42)
                                    
                                    Image(systemName: iconName(for: notification.type))
                                        .foregroundColor(iconColor(for: notification.type))
                                }

                                VStack(alignment: .leading, spacing: 6) {
                                    
                                    Text(notification.title)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.primary)
                                    
                                    Text(notification.message)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.leading)
                                    
                                    Text(notification.date, style: .time)
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 3)
                            .padding(.horizontal)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
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

        case .followUpConsultation:
            appState.currentItem = BookableItem(
                serviceType: .doctor,
                title: "Dr. Patricia Ahoy",
                subtitle: "ENT Specialist",
                price: 0,
                image: "doctor1",
                room: "Room 204",
                floor: "Ground Floor"
            )

            appState.queueNumber = Int.random(in: 1...20)
            appState.hasActiveAppointment = true
            appState.selectedTab = 0
            appState.navigateToDoctorSuccess = true

        case .labAppointment:
            appState.selectedTab = 0
            appState.navigateToLabBooking = true

        case .waitingUpdated:
            break
        }
    }
    
    func iconName(for type: NotificationType) -> String {
        
        switch type {
            
        case .consultationReady:
            return "stethoscope"
            
        case .yourTurn:
            return "person.crop.circle.badge.checkmark"
            
        case .labReady, .labAppointment:
            return "cross.case"
            
        case .pharmacyReady:
            return "pills"
            
        case .followUpConsultation:
            return "calendar.badge.clock"
            
        case .waitingUpdated:
            return "clock"
        }
    }

    func iconColor(for type: NotificationType) -> Color {
        
        switch type {
            
        case .consultationReady:
            return .blue
            
        case .yourTurn:
            return .green
            
        case .labReady, .labAppointment:
            return .purple
            
        case .pharmacyReady:
            return .orange
            
        case .followUpConsultation:
            return .teal
            
        case .waitingUpdated:
            return .gray
        }
    }
}

#Preview {
    let state = AppState()
    
    state.addNotification(
        type: .labAppointment,
        title: "Laboratory Appointment",
        message: "Your laboratory appointment booked from the portal"
    )
    state.addNotification(
        type: .followUpConsultation,
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

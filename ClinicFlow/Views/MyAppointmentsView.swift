import SwiftUI

struct MyAppointmentsView: View {
    // 1. Access the global AppState
    @EnvironmentObject var appState: AppState
    
    @State private var showReasonPopup = false
    @State private var showConfirmPopup = false
    @State private var showSuccessPopup = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 16) {
                    
                    // 2. Use appState.drJosephStatus instead of "In Progress"
                    AppointmentCard(
                        doctor: "Dr. Joseph Brostito",
                        specialty: "Dental Specialist",
                        date: "Sunday, 12 June",
                        time: "11:00 - 12:00 AM",
                        status: appState.drJosephStatus,
                        statusColor: appState.drJosephStatus == "Cancelled" ? .red : .headerColor
                    ) {
                        // Only allow clicking the cancel button if it's not already cancelled
                        if appState.drJosephStatus != "Cancelled" {
                            showReasonPopup = true
                        }
                    }
                    
                    AppointmentCard(
                        doctor: "Dr. Nimal Perera",
                        specialty: "Psychiatrist",
                        date: "Sunday, 12 June",
                        time: "11:00 - 12:00 AM",
                        status: "Completed",
                        statusColor: .blue
                    )
                }
                .padding()
            }
            
            if showReasonPopup {
                CancelReasonPopup(
                    onBack: { showReasonPopup = false },
                    onCancel: {
                        showReasonPopup = false
                        showConfirmPopup = true
                    }
                )
            }
            
            if showConfirmPopup {
                ConfirmCancelPopup(
                    onCancel: { showConfirmPopup = false },
                    onContinue: {
                        showConfirmPopup = false
                        showSuccessPopup = true
                    }
                )
            }
            
            if showSuccessPopup {
                CancelSuccessPopup(
                    onOK: {
                        // 3. Trigger the cancellation logic here
                        appState.cancelJosephAppointment()
                        showSuccessPopup = false
                    },
                    onBookAgain: {
                        appState.cancelJosephAppointment()
                        showSuccessPopup = false
                        // Navigate back to home tab
                        appState.selectedTab = 0
                    }
                )
            }
        }
    }
}

#Preview {
    // Ensure the preview has the environment object or it will crash
    MyAppointmentsView()
        .environmentObject(AppState())
}

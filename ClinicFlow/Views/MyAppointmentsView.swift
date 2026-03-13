import SwiftUI

struct MyAppointmentsView: View {
    @EnvironmentObject var appState: AppState
    
    @State private var showReasonPopup = false
    @State private var showConfirmPopup = false
    @State private var showSuccessPopup = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 16) {
                    

                    AppointmentCard(
                        imageName: "doctor3",
                        doctor: "Dr. Joseph Brostito",
                        specialty: "Dental Specialist",
                        date: "Sunday, 12 June",
                        time: "11:00 - 12:00 AM",
                        status: appState.drJosephStatus,
                        statusColor: appState.drJosephStatus == "Cancelled" ? .red : .headerColor
                    ) {

                        if appState.drJosephStatus != "Cancelled" {
                            showReasonPopup = true
                        }
                    }
                    
                    AppointmentCard(
                        imageName: "doctor4",
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
                        appState.cancelJosephAppointment()
                        showSuccessPopup = false
                    },
                    onBookAgain: {
                        appState.cancelJosephAppointment()
                        showSuccessPopup = false
                        appState.selectedTab = 0
                    }
                )
            }
        }
    }
}

#Preview {
    MyAppointmentsView()
        .environmentObject(AppState())
}

import SwiftUI

struct MyAppointmentsView: View {
    
    @State private var showReasonPopup = false
    @State private var showConfirmPopup = false
    @State private var showSuccessPopup = false
    
    var body: some View {
        
        ZStack {
            
            ScrollView {
                VStack(spacing: 16) {
                    
                    AppointmentCard(
                        doctor: "Dr. Joseph Brostito",
                        specialty: "Dental Specialist",
                        date: "Sunday, 12 June",
                        time: "11:00 - 12:00 AM",
                        status: "In Progress"
                    ) {
                        showReasonPopup = true
                    }
                    
                    AppointmentCard(
                        doctor: "Dr. Nimal Perera",
                        specialty: "Psychiatrist",
                        date: "Sunday, 12 June",
                        time: "11:00 - 12:00 AM",
                        status: "Completed"
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
                    onOK: { showSuccessPopup = false },
                    onBookAgain: { showSuccessPopup = false }
                )
            }
        }
    }
}

#Preview {
    MyAppointmentsView()
}

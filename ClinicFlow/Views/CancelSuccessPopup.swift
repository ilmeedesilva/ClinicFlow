import SwiftUI

struct CancelSuccessPopup: View {
    
    @EnvironmentObject var appState: AppState
    
    var onOK: () -> Void
    var onBookAgain: () -> Void
    
    var body: some View {
        
        popupContainer {
            
            Image("successimg")
                .font(.system(size: 70))
                .foregroundColor(.teal)
            
            Text("Appointment Successfully Cancelled")
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Text("Only 90% of funds have been returned to your account")
                .font(.caption)
                .multilineTextAlignment(.center)
            
            Button("OK") {
                onOK()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.headerColor)
            )
            
            Button("Book Again") {
                appState.selectedTab = 0
                onBookAgain()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.headerColor)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}

#Preview {
    CancelSuccessPopup(
        onOK: {},
        onBookAgain: {}
    )
    .environmentObject(AppState())
}

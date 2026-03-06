import SwiftUI

struct ConfirmCancelPopup: View {
    
    var onCancel: () -> Void
    var onContinue: () -> Void
    
    var body: some View {
        
        popupContainer {
            
            Text("Cancel Booking")
                .font(.headline)
            
            Divider()
            
            Text("Are you sure you want to cancel this appointment?")
                .multilineTextAlignment(.center)
            
            Text("Only 90% of funds will be returned to your account based on terms and conditions")
                .font(.caption)
                .multilineTextAlignment(.center)
            
            Button("No, Don't Cancel") {
                onCancel()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.headerColor)
            )
            
            Button("Continue Cancellation") {
                onContinue()
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
    ConfirmCancelPopup(
        onCancel: {},
        onContinue: {}
    )
}

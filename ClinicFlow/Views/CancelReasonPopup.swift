import SwiftUI

struct CancelReasonPopup: View {
    
    @State private var selectedReason: String? = nil
    
    let reasons = [
        "Schedule conflict",
        "Traveling out of town",
        "Weather concerns",
        "Booked by mistake",
        "Health Issues",
        "Personal emergency",
        "Other"
    ]
    
    var onBack: () -> Void
    var onCancel: () -> Void
    
    let tealColor = Color(red: 0.18, green: 0.41, blue: 0.45)
    
    var body: some View {
        
        ZStack {
            
            // Background dim
            Color.black.opacity(0.35)
                .ignoresSafeArea()
            
            // Popup Card
            VStack(spacing: 22) {
                
                Text("Cancel Booking")
                    .font(.system(size: 22, weight: .bold))
                
                Text("Choose a reason for cancellation:")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                
                
                // MARK: Reasons List
                
                VStack(alignment: .leading, spacing: 18) {
                    
                    ForEach(reasons, id: \.self) { reason in
                        
                        Button {
                            selectedReason = reason
                        } label: {
                            
                            HStack(spacing: 14) {
                                
                                ZStack {
                                    Circle()
                                        .stroke(tealColor, lineWidth: 2)
                                        .frame(width: 24, height: 24)
                                    
                                    if selectedReason == reason {
                                        Circle()
                                            .fill(tealColor)
                                            .frame(width: 12, height: 12)
                                    }
                                }
                                
                                Text(reason)
                                    .font(.system(size: 16))
                                    .foregroundColor(.blue)
                                
                                Spacer()
                            }
                        }
                    }
                }
                .padding(.top, 5)
                
                
                // MARK: Buttons
                
                HStack(spacing: 16) {
                    
                    Button {
                        onBack()
                    } label: {
                        Text("Back")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(tealColor)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(tealColor, lineWidth: 1.5)
                            )
                    }
                    
                    
                    Button {
                        onCancel()
                    } label: {
                        Text("Cancel Booking")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(tealColor)
                            .cornerRadius(10)
                    }
                    .disabled(selectedReason == nil)
                    .opacity(selectedReason == nil ? 0.6 : 1)
                }
                .padding(.top, 10)
                
            }
            .padding(26)
            .background(Color.white)
            .cornerRadius(22)
            .padding(.horizontal, 30)
        }
    }
}

#Preview {
    CancelReasonPopup(
        onBack: {},
        onCancel: {}
    )
}

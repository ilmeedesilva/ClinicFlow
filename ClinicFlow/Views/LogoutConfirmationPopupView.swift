import SwiftUI

struct LogoutOverlayView: View {
    
    let title: String
    let subtitle: String
    let confirmButtonTitle: String
    let cancelButtonTitle: String
    let onConfirm: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    onCancel()
                }
            
            VStack(spacing: 24) {
                // MARK: Icon Section
                ZStack {
                    Circle()

                        .fill(Color(hex: "#2D6876").opacity(0.1))
                        .frame(width: 100, height: 100)
                    
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(Color(hex: "#2D6876"))
                }
                .padding(.top, 10)
                
                // MARK: Text Section
                VStack(spacing: 8) {
                    Text(title)
                        .font(.title3)
                        .bold()
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }
                
                // MARK: Buttons
                HStack(spacing: 12) {
                    Button(action: onCancel) {
                        Text(cancelButtonTitle)
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                    }
                    
                    Button(action: onConfirm) {
                        Text(confirmButtonTitle)
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color(hex: "#2D6876"))
                            .cornerRadius(12)
                    }
                }
            }
            .padding(24)
            .background(Color.white)
            .cornerRadius(24)
            .padding(.horizontal, 30)
        }
    }
}

#Preview("Logout Confirmation") {
    LogoutOverlayView(
        title: "Log Out",
        subtitle: "Are you sure you want to log out of your account?",
        confirmButtonTitle: "Log Out",
        cancelButtonTitle: "Cancel",
        onConfirm: {
            print("User Logged Out")
        },
        onCancel: {
            print("Cancelled")
        }
    )
}

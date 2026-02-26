import SwiftUI

struct SuccessOverlayView: View {
    
    let title: String
    let subtitle: String
    let buttonTitle: String
    let action: () -> Void
    
    var body: some View {
        
        ZStack {
            
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                ZStack {
                    Circle()
                        .fill(Color(hex: "#2D6876"))
                        .frame(width: 120, height: 120)
                    
                    Image("successimg")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Text(title)
                    .font(.title3)
                    .bold()
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .padding(40)
        }
    }
}

#Preview("Success Overlay") {
    SuccessOverlayView(
        title: "Successful",
        subtitle: "You have successfully logged in",
        buttonTitle: "Redirecting..."
    ) {
        print("Action")
    }
}

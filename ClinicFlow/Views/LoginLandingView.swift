import SwiftUI

struct LoginLandingView: View {
    
    var body: some View {
        
        VStack(spacing: 24) {
            
            Image("Hospitalimg")
                .resizable()
                .scaledToFit()
                .frame(height: 280)
            
            Text("Welcome!")
                .font(.title)
                .bold()
            
            Text("Begin your journey to better health!")
                .foregroundColor(.gray)
            
            NavigationLink {
                PhoneLoginView()
            } label: {
                Text("Continue with Phone Number")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#2D6876"))
                    .cornerRadius(12)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview("Login Landing") {
    NavigationStack {
        LoginLandingView()
            .environmentObject(AppState())
    }
}

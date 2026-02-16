import SwiftUI

struct StartView: View {
    
    @Binding var isLoggedIn: Bool
    @State private var goToLogin = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                
                Image("startingimg")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 500)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome!")
                        .font(.title)
                        .bold()
                    
                    Text("Track your clinical visits today")
                        .font(.title3)
                        .bold()
                    
                    Text("Begin your journey to better health!")
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 150)
                .background(Color.startingBox)
                .cornerRadius(15)
                .padding(.horizontal)
                
                Spacer()
                
                Button {
                    goToLogin = true
                } label: {
                    Text("Get Started !")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.primaryButton)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .navigationDestination(isPresented: $goToLogin) {
                    LoginView(isLoggedIn: $isLoggedIn)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    StartView(isLoggedIn: .constant(false))
}


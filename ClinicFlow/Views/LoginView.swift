import SwiftUI

struct LoginView: View {
    
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // MARK: Top Image
            Image("Hospitalimg")
                .resizable()
                .scaledToFill()
                .frame(height: 300)
                .clipped()
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: Title
                    Text("Welcome!")
                        .font(.system(size: 28, weight: .bold))
                    
                    Text("Begin your journey to better health!")
                        .foregroundColor(.gray)
                    
                    // MARK: Continue With Phone
                    NavigationLink {
                        PhoneLoginView()
                    } label: {
                        Text("Continue with Phone Number")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "#2D6876"))
                            .cornerRadius(14)
                    }
                    
                    // MARK: Google Button
                    Button {
                        // Future Google login
                    } label: {
                        HStack {
                            Image("google")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                            
                            Text("Sign in with Google")
                                .foregroundColor(Color(hex: "#2D6876"))
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color(hex: "#2D6876"), lineWidth: 1.5)
                        )
                    }
                    
                    // MARK: Apple Button
                    Button {
                        // Future Apple login
                    } label: {
                        HStack {
                            Image(systemName: "applelogo")
                            Text("Sign in with Apple")
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#2D6876"))
                        .cornerRadius(14)
                    }
                    
                    Spacer(minLength: 40)
                    
                    // MARK: Terms
                    VStack(spacing: 4) {
                        Text("By signing up or logging in, i accept the apps")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 4) {
                            Text("Terms of Service")
                                .underline()
                            Text("and")
                            Text("Privacy Policy")
                                .underline()
                        }
                        .font(.caption)
                        .foregroundColor(Color(hex: "#2D6876"))
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    LoginView(isLoggedIn: .constant(false))
}

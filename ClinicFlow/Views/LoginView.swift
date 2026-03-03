import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 0) {
            Image("Hospitalimg")
                .resizable()
                .scaledToFill()
                .frame(height: 300)
                .clipped()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Welcome!")
                        .font(.system(size: 28, weight: .bold))
                    
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
                            .cornerRadius(14)
                    }
                    
                    // MARK: Google Login
                    Button {
                        withAnimation {
                            appState.isLoggedIn = true
                        }
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
                        .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color(hex: "#2D6876"), lineWidth: 1.5))
                    }
                    
                    // MARK: Apple Login 
                    Button {
                        withAnimation {
                            appState.isLoggedIn = true
                        }
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
                    
                    VStack(spacing: 4) {
                        Text("By signing up or logging in, i accept the apps").font(.caption).foregroundColor(.gray)
                        HStack(spacing: 4) {
                            Text("Terms of Service").underline()
                            Text("and")
                            Text("Privacy Policy").underline()
                        }.font(.caption).foregroundColor(Color(hex: "#2D6876"))
                    }.frame(maxWidth: .infinity)
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
#Preview {
    let mockState = AppState()
    
    mockState.isLoggedIn = false
    
    return LoginView()
        .environmentObject(mockState)
}

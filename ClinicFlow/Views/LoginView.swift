import SwiftUI

struct LoginView: View {
    
    @Binding var isLoggedIn: Bool
    
    @Environment(\.dismiss) var dismiss
    
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Custom Back Button
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                Spacer()
            }
            
            Text("Welcome Back")
                .font(.largeTitle)
                .bold()
            
            Text("Please enter a form to login this app")
                .foregroundColor(.gray)
            
            // Email
            VStack(alignment: .leading) {
                Text("Email or Username")
                
                TextField("Enter your full name", text: $email)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.inputStroke, lineWidth: 1)
                    )
            }
            
            // Password
            VStack(alignment: .leading) {
                Text("Password")
                
                HStack {
                    if showPassword {
                        TextField("Enter your password", text: $password)
                    } else {
                        SecureField("Enter your password", text: $password)
                    }
                    
                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye" : "eye.slash")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.inputStroke, lineWidth: 1)
                )
            }
            
            // Sign In Button
            Button {
                login()
            } label: {
                Text("Sign In")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFormValid ? Color.primaryButton : Color.gray.opacity(0.4))
                    .cornerRadius(10)
            }
            .disabled(!isFormValid)
            
            // Register Link
            NavigationLink("Don't have an account? Register",
                           destination: RegisterView(isLoggedIn: $isLoggedIn))
                .foregroundColor(Color.primaryButton)
            
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .alert("Login Error", isPresented: $showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
    }
    
    // MARK: - Login Logic
    func login() {
        if email == "admin" && password == "1234" {
            isLoggedIn = true
        } else {
            errorMessage = "Invalid username or password"
            showError = true
        }
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false))
}

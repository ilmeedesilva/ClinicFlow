import SwiftUI

struct RegisterView: View {
    
    @Binding var isLoggedIn: Bool
    
    @Environment(\.dismiss) var dismiss
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    var isFormValid: Bool {
        !fullName.isEmpty &&
        !email.isEmpty &&
        !password.isEmpty &&
        !confirmPassword.isEmpty
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Custom Back
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                Spacer()
            }
            
            Text("Register")
                .font(.largeTitle)
                .bold()
            
            Text("Please enter a form to continue the register")
                .foregroundColor(.gray)
            
            inputField(title: "Full Name",
                       text: $fullName,
                       placeholder: "Enter your full name")
            
            inputField(title: "Email",
                       text: $email,
                       placeholder: "Enter your Email")
            
            // Password
            passwordField(title: "Password",
                          text: $password,
                          show: $showPassword)
            
            // Confirm Password
            passwordField(title: "Confirm password",
                          text: $confirmPassword,
                          show: $showConfirmPassword)
            
            Button {
                register()
            } label: {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFormValid ? Color.primaryButton : Color.gray.opacity(0.4))
                    .cornerRadius(10)
            }
            .disabled(!isFormValid)
            
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .alert("Registration Error", isPresented: $showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
    }
    
    // MARK: - Components
    
    func inputField(title: String,
                    text: Binding<String>,
                    placeholder: String) -> some View {
        
        VStack(alignment: .leading) {
            Text(title)
            
            TextField(placeholder, text: text)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.inputStroke, lineWidth: 1)
                )
        }
    }
    
    func passwordField(title: String,
                       text: Binding<String>,
                       show: Binding<Bool>) -> some View {
        
        VStack(alignment: .leading) {
            Text(title)
            
            HStack {
                if show.wrappedValue {
                    TextField("Enter your password", text: text)
                } else {
                    SecureField("Enter your password", text: text)
                }
                
                Button {
                    show.wrappedValue.toggle()
                } label: {
                    Image(systemName: show.wrappedValue ? "eye" : "eye.slash")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.inputStroke, lineWidth: 1)
            )
        }
    }
    
    // MARK: - Register Logic
    
    func register() {
        if password != confirmPassword {
            errorMessage = "Passwords do not match"
            showError = true
            return
        }
        
        // Auto login after successful registration
        isLoggedIn = true
    }
}

#Preview {
    RegisterView(isLoggedIn: .constant(false))
}

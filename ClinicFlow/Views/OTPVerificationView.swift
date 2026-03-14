import SwiftUI

struct OTPVerificationView: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    
    let phoneNumber: String
    
    @State private var otpDigits: [String] = Array(repeating: "", count: 6)
    @FocusState private var focusedIndex: Int?
    @State private var showSuccess = false
    
    @State private var showPolicy = false
    @State private var selectedPolicyTitle = ""
    
    @State private var timeRemaining = 59
    @State private var timer: Timer?
    
    var otpInput: String {
        otpDigits.joined()
    }
    
    var isValidOTP: Bool {
        otpInput.count == 6
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
//                HStack {
//                    Button {
//                        dismiss()
//                    } label: {
//                        Image(systemName: "chevron.left")
//                            .foregroundColor(.black)
//                    }
//                    Spacer()
//                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("OTP Code")
                        .font(.title2)
                        .bold()
                    
                    Text("Enter the 6-digit that we have sent via the phone number to \(phoneNumber)")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 12) {
                    ForEach(0..<6, id: \.self) { index in
                        otpBox(index: index)
                    }
                }
                .padding(.top, 10)

                HStack(spacing: 6) {
                    Image(systemName: "stopwatch.fill")
                        .foregroundColor(Color(hex: "#2D6876"))
                    
                    Text(String(format: "00:%02d", timeRemaining))
                        .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Button {
                    resendCode()
                } label: {
                    Text("Resend Code")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(hex: "#2D6876"), lineWidth: 1)
                        )
                }
                .disabled(timeRemaining > 0)
                .opacity(timeRemaining > 0 ? 0.5 : 1)
                
                Button {
                    verifyOTP()
                } label: {
                    Text("Continue")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isValidOTP ? Color(hex: "#2D6876") : Color.gray)
                        .cornerRadius(12)
                }
                .disabled(!isValidOTP)
                

                VStack(spacing: 4) {
                    Text("By signing up or logging in, i accept the apps")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    HStack(spacing: 4) {
                        Button {
                            selectedPolicyTitle = "Terms and Conditions"
                            showPolicy = true
                        } label: {
                            Text("Terms of Service")
                                .underline()
                        }
                        
                        Text("and")
                        
                        Button {
                            selectedPolicyTitle = "Privacy Policy"
                            showPolicy = true
                        } label: {
                            Text("Privacy Policy")
                                .underline()
                        }
                    }
                    .font(.caption)
                    .foregroundColor(.black)
                }
            }
            .padding()
            
            if showSuccess {
                SuccessOverlayView(
                    title: "Successful",
                    subtitle: "You have successfully Logged in",
                    buttonTitle: "Redirecting..."
                ) {
                }
            }
        }
        .sheet(isPresented: $showPolicy) {
            PolicyView(title: selectedPolicyTitle)
        }
        .onAppear {
            startTimer()
            appState.sendOTP(to: phoneNumber)
            focusedIndex = 0
        }
    }
}

private extension OTPVerificationView {
    
    func otpBox(index: Int) -> some View {
        TextField("", text: $otpDigits[index])
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .frame(width: 45, height: 50)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .focused($focusedIndex, equals: index)
            .onChange(of: otpDigits[index]) { oldValue, newValue in
                if newValue.count > 1 {
                    otpDigits[index] = String(newValue.prefix(1))
                }
                
                if !newValue.isEmpty {
                    if index < 5 {
                        focusedIndex = index + 1
                    }
                } else {
                    if index > 0 {
                        focusedIndex = index - 1
                    }
                }
            }
    }
    
    func startTimer() {
        timeRemaining = 59
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
            }
        }
    }
    
    func resendCode() {
        startTimer()
        appState.sendOTP(to: phoneNumber)
    }
    
    func verifyOTP() {
        if appState.verifyOTP(otpInput) {
            showSuccess = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                appState.isLoggedIn = true
            }
        }
    }
}

#Preview("OTP Screen") {
    NavigationStack {
        OTPVerificationView(phoneNumber: "+947712312312")
            .environmentObject(AppState())
    }
}

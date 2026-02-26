import SwiftUI

struct PhoneLoginView: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    
    @State private var countries: [Country] = []
    @State private var selectedCountry: Country?
    @State private var phoneNumber = ""
    
    var isValidPhone: Bool {
        phoneNumber.count >= 9
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // MARK: Header
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding()
            
            Divider()
            
            // MARK: Main Content
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Login")
                    .font(.title)
                    .bold()
                
                Text("Please enter your number to continue your registration")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                
                Text("Phone Number")
                    .padding(.top, 20)
                
                // MARK: Phone Row
                HStack(spacing: 10) {
                    
                    Menu {
                        ForEach(countries) { country in
                            Button {
                                selectedCountry = country
                            } label: {
                                Text("\(country.flag) \(country.dialCode) \(country.name)")
                            }
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Text(selectedCountry?.flag ?? "🇱🇰")
                            Text(selectedCountry?.dialCode ?? "+94")
                            Image(systemName: "chevron.down")
                                .font(.system(size: 12))
                        }
                        .foregroundColor(.black)
                    }
                    
                    Divider()
                        .frame(height: 24)
                    
                    TextField("771231231", text: $phoneNumber)
                        .keyboardType(.numberPad)
                }
                .padding()
                .background(Color.gray.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.gray.opacity(0.4))
                )
                .cornerRadius(14)
                
                Spacer()
            }
            .padding()
            
            // MARK: Bottom Section
            VStack(spacing: 16) {
                
                NavigationLink {
                    OTPVerificationView(
                        phoneNumber: "\(selectedCountry?.dialCode ?? "")\(phoneNumber)"
                    )
                } label: {
                    Text("Send OTP")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isValidPhone ? Color(hex: "#2D6876") : Color.gray)
                        .cornerRadius(14)
                }
                .disabled(!isValidPhone)
                
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
                }
            }
            .padding()
            .background(Color.white)
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            countries = CountryProvider.loadCountries()
            selectedCountry = countries.first(where: { $0.isoCode == "LK" }) ?? countries.first
        }
    }
}

#Preview("Phone Login") {
    NavigationStack {
        PhoneLoginView()
            .environmentObject(AppState())
    }
}

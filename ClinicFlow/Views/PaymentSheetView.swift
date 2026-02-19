import SwiftUI

struct PaymentSheetView: View {
    
    let item: BookableItem
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState

    
    @State private var cardNumber = ""
    @State private var expiry = ""
    @State private var cvv = ""
    @State private var saveCard = false
    
    @State private var showTerms = false
    @State private var showPrivacy = false
    @State private var showRefund = false
    
    @State private var isProcessing = false
    @State private var showSuccess = false
    
    var body: some View {
        
        ZStack {
            
            // MARK: Dim Background
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // MARK: Popup Card
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: Header
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Text("Payment")
                            .font(.headline)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.left")
                            .opacity(0)
                    }
                    
                    Divider()
                    
                    // MARK: Payment Method Title
                    Text("Payment Method")
                        .font(.headline)
                    
                    // MARK: Payment Icons
                    HStack(spacing: 16) {
                        Spacer()
                        paymentIcon("visa")
                        paymentIcon("master")
                        paymentIcon("paypal")
                        Spacer()
                    }
                    
                    // MARK: Card Details
                    Text("Card Details")
                        .font(.headline)
                    
                    inputField("Card Number", text: $cardNumber)
                    inputField("Expiration Date", text: $expiry)
                    inputField("CVV", text: $cvv)
                    
                    // MARK: Save Card Checkbox
                    HStack {
                        Button {
                            saveCard.toggle()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .stroke(Color.headerColor, lineWidth: 1.5)
                                    .frame(width: 22, height: 22)
                                
                                if saveCard {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(Color.headerColor)
                                }
                            }
                        }
                        
                        Text("Save Card Details")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    
                    // MARK: Terms & Policies
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("By confirming your payment, you acknowledge and agree to our")
                            .font(.caption)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        HStack(spacing: 4) {
                            linkText("Terms & Conditions") { showTerms = true }
                            Text(",")
                            linkText("Privacy Policy") { showPrivacy = true }
                            Text("and")
                            linkText("Refund Policy") { showRefund = true }
                        }
                        .font(.caption)
                        
                        Text("Please review your clinic visit details carefully, including the selected service, appointment date, and payment method. Once the payment is confirmed, changes may be subject to clinic policies.")
                            .font(.caption)
                            .fixedSize(horizontal: false, vertical: true)

                        Text("Refunds or rescheduling options are available according to clinic guidelines. To learn more, read our full")
                            .font(.caption)
                            .fixedSize(horizontal: false, vertical: true)

                        linkText("Refund Policy") { showRefund = true }
                            .font(.caption)
                    }
                    
                    Spacer()
                    
                    // MARK: Pay Button
                    Button {
                        processPayment()
                    } label: {
                        Text(isProcessing ? "Processing..." : "Pay Rs \(Int(item.price)).00")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.headerColor)
                            .cornerRadius(14)
                    }
                    .disabled(isProcessing)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(25)
                .padding(.horizontal, 20)
            }
        }
        
        // MARK: Policy Sheets
        .sheet(isPresented: $showTerms) {
            PolicyView(title: "Terms & Conditions")
        }
        .sheet(isPresented: $showPrivacy) {
            PolicyView(title: "Privacy Policy")
        }
        .sheet(isPresented: $showRefund) {
            PolicyView(title: "Refund Policy")
        }
        
        // MARK: Success Screen
        .fullScreenCover(isPresented: $showSuccess) {
            PaymentSuccessView(item: item)
                .environmentObject(appState)
        }

    }
    
    
    // MARK: Process Payment
    func processPayment() {
        isProcessing = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isProcessing = false
            
            appState.createAppointment(for: item)
            showSuccess = true
        }
    }

    
    
    // MARK: Payment Icon
    func paymentIcon(_ name: String) -> some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 50)
            .background(Color.headerColor.opacity(0.15))
            .cornerRadius(12)
    }
    
    
    // MARK: Input Field
    func inputField(_ placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.headerColor, lineWidth: 1)
            )
    }
    
    
    // MARK: Link Text
    func linkText(_ text: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(text)
                .underline()
                .foregroundColor(.blue)
        }
    }
}


#Preview("Doctor Payment Sheet") {
    
    let appState = AppState()
    
    return ZStack {
        Color.black.opacity(0.4).ignoresSafeArea()
        
        PaymentSheetView(
            item: BookableItem(
                serviceType: .doctor,
                title: "Dr. Patricia Ahoy",
                subtitle: "ENT Specialist",
                price: 2500,
                image: "doctor1",
                room: "Room 204",
                floor: "Ground Floor"
            )
        )
        .environmentObject(appState)
    }
}


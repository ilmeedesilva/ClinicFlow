import SwiftUI

struct PharmacyPaymentReadyView: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedMethod: PaymentMethod = .card
    @State private var showPaymentSheet = false

    
    enum PaymentMethod {
        case card
        case cash
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            AppHeader(title: "Payment")
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: Success Circle
                    VStack(spacing: 16) {
                        
                        ZStack {
                            Circle()
                                .stroke(Color(hex: "#2D6876"), lineWidth: 12)
                                .frame(width: 140, height: 140)
                            
                            Image(systemName: "checkmark")
                                .font(.system(size: 50, weight: .bold))
                                .foregroundColor(Color(hex: "#2D6876"))
                        }
                        
                        Text("Your Medicines are Ready")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Divider()
                    
                    // MARK: Queue Number
                    VStack(spacing: 8) {
                        Text("Queue Number")
                            .font(.headline)
                        
                        Text("\(appState.queueNumber)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(width: 70, height: 50)
                            .background(Color.lightGrayBG)
                            .cornerRadius(12)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Divider()
                    
                    // MARK: Payment Method
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Select Payment Method")
                            .font(.headline)
                        
                        paymentRow(icon: "card", title: "Credit/ Debit Card", method: .card)
                        paymentRow(icon: "cash", title: "Cash", method: .cash)
                    }
                    
                    Divider()
                    
                    // MARK: Medicine Details
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("Medicine Details")
                            .font(.headline)
                        
                        HStack {
                            Text("Paracetamol 500mg (20 tablets)")
                                .foregroundColor(.gray)
                            Spacer()
                            Text("Rs 350.00")
                                .fontWeight(.medium)
                        }
                        
                        HStack {
                            Text("Amoxicillin 250mg (10 capsules)")
                                .foregroundColor(.gray)
                            Spacer()
                            Text("Rs 450.00")
                                .fontWeight(.medium)
                        }
                    }
                    
                    Divider()
                    
                    // MARK: Total
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("Total payment")
                            .font(.headline)
                        
                        HStack {
                            Text("Medicine Fee")
                                .foregroundColor(.gray)
                            Spacer()
                            Text("Rs 800.00")
                                .fontWeight(.medium)
                        }
                        
                        HStack {
                            Text("Admin")
                                .foregroundColor(.gray)
                            Spacer()
                            Text("Free")
                                .fontWeight(.medium)
                        }
                    }
                    
                    Spacer(minLength: 40)
                }
                .padding()
            }
            
            // MARK: Bottom Pay Button
            VStack {
                Divider()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Total")
                            .foregroundColor(.gray)
                        Text("Rs 800.00")
                            .font(.system(size: 18, weight: .bold))
                    }
                    
                    Spacer()
                    
                    Button {
                        showPaymentSheet = true
                    } label: {
                        Text("Pay")
                            .foregroundColor(.white)
                            .frame(width: 120, height: 50)
                            .background(Color.headerColor)
                            .cornerRadius(14)
                    }
                    .sheet(isPresented: $showPaymentSheet) {
                        if let item = appState.currentItem {
                            PaymentSheetView(item: item)
                                .environmentObject(appState)
                        }
                    }

                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
    
    func paymentRow(icon: String, title: String, method: PaymentMethod) -> some View {
        Button {
            selectedMethod = method
        } label: {
            HStack {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                
                Text(title)
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(Color.headerColor, lineWidth: 1.5)
                        .frame(width: 22, height: 22)
                    
                    if selectedMethod == method {
                        Circle()
                            .fill(Color.headerColor)
                            .frame(width: 12, height: 12)
                    }
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    func resetFlow() {
        appState.hasActiveAppointment = false
        appState.currentStage = .awaiting
        appState.shouldNavigateToPharmacyPayment = false
        dismiss()
    }
}

#Preview {
    let state = AppState()
    state.queueNumber = 10
    state.currentItem = BookableItem(
        serviceType: .pharmacy,
        title: "Prescription Order",
        subtitle: "Medicine Collection",
        price: 800,
        image: "pharmacy",
        room: "Counter 03",
        floor: "First Floor"
    )
    
    return PharmacyPaymentReadyView()
        .environmentObject(state)
}

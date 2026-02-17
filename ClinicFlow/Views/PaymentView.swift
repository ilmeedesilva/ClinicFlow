import SwiftUI

struct PaymentView: View {
    
    let item: BookableItem
    
    @State private var selectedQueue = 14
    @State private var selectedMethod: PaymentMethod = .card
    
    @State private var patientName = ""
    @State private var age = ""
    @State private var gender = ""
    @State private var contact = ""
    
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
                    
                    // MARK: Doctor Details
                    HStack(spacing: 12) {
                        Image(item.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title)
                                .font(.system(size: 18, weight: .bold))
                            
                            Text(item.subtitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Divider()
                    
                    // MARK: Appointment Queue
                    AppointmentQueueView()
                    
                    Divider()
                    
                    // MARK: Payment Method
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Select Payment Method")
                            .font(.headline)
                        
                        paymentRow(
                            icon: "card",
                            title: "Credit/ Debit Card",
                            method: .card
                        )
                        
                        paymentRow(
                            icon: "cash",
                            title: "Cash",
                            method: .cash
                        )
                    }
                    
                    Divider()
                    
                    // MARK: Optional Fields
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Optional")
                            .font(.headline)
                        
                        inputField("Patient Name", text: $patientName)
                        inputField("Age", text: $age)
                        inputField("Gender", text: $gender)
                        inputField("Contact Number", text: $contact)
                    }
                    
                    Divider()
                    
                    // MARK: Totals
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("Total payment")
                            .font(.headline)
                        
                        HStack {
                            Text("Consultation Fee")
                                .foregroundColor(.gray)
                            Spacer()
                            Text("Rs \(Int(item.price)).00")
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
            
            // MARK: Bottom Pay Section
            VStack {
                Divider()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Total")
                            .foregroundColor(.gray)
                        
                        Text("Rs \(Int(item.price)).00")
                            .font(.system(size: 18, weight: .bold))
                    }
                    
                    Spacer()
                    
                    Button {
                        if selectedMethod == .card {
                            showPaymentSheet = true
                        } else {
                            print("Cash selected – booking confirmed")
                        }
                    } label: {
                        Text("Pay")
                            .foregroundColor(.white)
                            .frame(width: 120, height: 50)
                            .background(Color.headerColor)
                            .cornerRadius(14)
                    }
                    .sheet(isPresented: $showPaymentSheet) {
                        PaymentSheetView(amount: item.price)
                    }

                }
                .padding()
            }
            .background(Color.white)
        }
        .navigationBarHidden(true)
    }
    
    // MARK: Queue Box
    func queueBox(_ number: Int) -> some View {
        Button {
            selectedQueue = number
        } label: {
            Text("\(number)")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(selectedQueue == number ? .white : .black)
                .frame(width: 70, height: 60)
                .background(
                    selectedQueue == number
                    ? Color.headerColor
                    : Color.lightGrayBG
                )
                .cornerRadius(16)
        }
    }
    
    // MARK: Payment Row
    func paymentRow(icon: String, title: String, method: PaymentMethod) -> some View {
        Button {
            selectedMethod = method
        } label: {
            HStack(spacing: 12) {
                
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
    
    // MARK: Input Field
    func inputField(_ placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.headerColor, lineWidth: 1)
            )
    }
}

#Preview("Payment View") {
    let mockItem = BookableItem(
        serviceType: .doctor,
        title: "Dr. Patricia Ahoy",
        subtitle: "ENT Specialist",
        price: 2500,
        image: "doctor1"
    )
    return NavigationStack {
        PaymentView(item: mockItem)
    }
}

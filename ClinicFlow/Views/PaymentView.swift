import SwiftUI

struct PaymentView: View {
    
    @EnvironmentObject var appState: AppState
    let item: BookableItem
    
    @State private var selectedQueue = 14
    @State private var selectedMethod: PaymentMethod = .card
    
    @State private var selectedPatientID: UUID?
    @State private var isAddingNewMember = false
    
    @State private var patientName = ""
    @State private var age = ""
    @State private var gender = ""
    @State private var contact = ""
    @State private var relationship = "Select Relationship"
    
    @State private var showPaymentSheet = false
    
    enum PaymentMethod {
        case card
        case cash
    }
    
    let relationships = [
        "You", "Father", "Mother", "Brother", "Sister",
        "Spouse", "Son", "Daughter", "Other"
    ]
    
    // MARK: Validation
    
    var isAgeValid: Bool {
        Int(age) != nil && Int(age)! > 0
    }
    
    var isContactValid: Bool {
        contact.count >= 9 && contact.allSatisfy { $0.isNumber }
    }
    
    var isNewMemberValid: Bool {
        !patientName.isEmpty &&
        isAgeValid &&
        !gender.isEmpty &&
        isContactValid &&
        relationship != "Select Relationship"
    }
    
    var canProceedToPay: Bool {
        if isAddingNewMember {
            return isNewMemberValid
        } else {
            return selectedPatientID != nil
        }
    }
    
    var feeTitle: String {
        switch item.serviceType {
        case .doctor: return "Consultation Fee"
        case .laboratory: return "Laboratory Fee"
        case .pharmacy: return "Medicine Fee"
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            AppHeader(title: "Payment")
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    doctorDetails
                    
                    Divider()
                    
                    AppointmentQueueView()
                    
                    Divider()
                    
                    selectPatientSection
                    
                    Divider()
                    
                    paymentMethodSection
                    
                    Divider()
                    
                    totalsSection
                    
                    Spacer(minLength: 40)
                }
                .padding()
            }
            
            bottomPaySection
        }
        .navigationBarHidden(true)
        .animation(.easeInOut, value: isAddingNewMember)
        
        .sheet(isPresented: $showPaymentSheet) {
                PaymentSheetView(item: item)
                    .environmentObject(appState)
            }
    }
       
}

// MARK: Sections

extension PaymentView {
    
    var doctorDetails: some View {
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
    }
    
    var selectPatientSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Select Patient")
                .font(.headline)
            
            ForEach(appState.familyMembers) { member in
                patientRow(member: member)
            }
            
            Button {
                isAddingNewMember = true
                selectedPatientID = nil
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Add New Member")
                    Spacer()
                }
            }
            .buttonStyle(.plain)
            
            if isAddingNewMember {
                newMemberForm
            }
        }
    }
    
    func patientRow(member: FamilyMember) -> some View {
        Button {
            selectedPatientID = member.id
            isAddingNewMember = false
        } label: {
            HStack(spacing: 12) {
                
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                
                Text(member.name)
                
                Spacer()
                
                radioButton(isSelected: selectedPatientID == member.id)
            }
        }
        .buttonStyle(.plain)
    }
    
    var newMemberForm: some View {
        VStack(spacing: 12) {
            
            inputField("Patient Name", text: $patientName, isValid: !patientName.isEmpty)
            
            inputField("Age", text: $age, isValid: isAgeValid)
                .keyboardType(.numberPad)
            
            Menu {
                Button("Male") { gender = "Male" }
                Button("Female") { gender = "Female" }
                Button("Other") { gender = "Other" }
            } label: {
                HStack {
                    Text(gender.isEmpty ? "Select Gender" : gender)
                        .foregroundColor(gender.isEmpty ? .gray : .black)
                    Spacer()
                    Image(systemName: "chevron.down")
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            gender.isEmpty ? Color.red : Color.headerColor,
                            lineWidth: 1
                        )
                )
            }
            
            inputField("Contact Number", text: $contact, isValid: isContactValid)
                .keyboardType(.numberPad)
            
            Menu {
                ForEach(relationships, id: \.self) { relation in
                    Button(relation) {
                        relationship = relation
                    }
                }
            } label: {
                HStack {
                    Text(relationship)
                        .foregroundColor(
                            relationship == "Select Relationship"
                            ? .gray
                            : .black
                        )
                    Spacer()
                    Image(systemName: "chevron.down")
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            relationship == "Select Relationship"
                            ? Color.red
                            : Color.headerColor,
                            lineWidth: 1
                        )
                )
            }
        }
        .transition(.move(edge: .top).combined(with: .opacity))
    }
    
    var paymentMethodSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Select Payment Method")
                .font(.headline)
            
            paymentRow(icon: "card", title: "Credit/ Debit Card", method: .card)
            paymentRow(icon: "cash", title: "Cash", method: .cash)
        }
    }
    
    var totalsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text("Total payment")
                .font(.headline)
            
            HStack {
                Text(feeTitle)
                    .foregroundColor(.gray)
                Spacer()
                Text("Rs \(Int(item.price)).00")
            }
            
            HStack {
                Text("Admin")
                    .foregroundColor(.gray)
                Spacer()
                Text("Free")
            }
        }
    }
    
    var bottomPaySection: some View {
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
                    if isAddingNewMember {
                        let newMember = FamilyMember(
                            name: patientName,
                            age: Int(age) ?? 0,
                            gender: gender,
                            contact: contact,
                            relationship: relationship
                        )
                        
                        appState.addFamilyMember(newMember)
                        appState.selectedPatient = newMember
                        selectedPatientID = newMember.id
                        isAddingNewMember = false
                        
                        clearForm()
                    } else {
                        if let id = selectedPatientID,
                           let member = appState.familyMembers.first(where: { $0.id == id }) {
                            appState.selectedPatient = member  
                        }
                    }
                    
                    showPaymentSheet = true
                } label: {
                    Text("Pay")
                        .foregroundColor(.white)
                        .frame(width: 120, height: 50)
                        .background(
                            canProceedToPay
                            ? Color.headerColor
                            : Color.gray.opacity(0.4)
                        )
                        .cornerRadius(14)
                }
                .disabled(!canProceedToPay)
            }
            .padding()
        }
        .background(Color.white)
    }
    
    func inputField(_ placeholder: String,
                    text: Binding<String>,
                    isValid: Bool) -> some View {
        
        TextField(placeholder, text: text)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        isValid ? Color.headerColor : Color.red,
                        lineWidth: 1
                    )
            )
    }
    
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
                radioButton(isSelected: selectedMethod == method)
            }
        }
        .buttonStyle(.plain)
    }
    
    func radioButton(isSelected: Bool) -> some View {
        ZStack {
            Circle()
                .stroke(Color.headerColor, lineWidth: 1.5)
                .frame(width: 22, height: 22)
            
            if isSelected {
                Circle()
                    .fill(Color.headerColor)
                    .frame(width: 12, height: 12)
            }
        }
    }
    
    func clearForm() {
        patientName = ""
        age = ""
        gender = ""
        contact = ""
        relationship = "Select Relationship"
    }
}

// MARK: Preview

#Preview("Payment View") {
    let mockItem = BookableItem(
        serviceType: .doctor,
        title: "Dr. Patricia Ahoy",
        subtitle: "ENT Specialist",
        price: 2500,
        image: "doctor1",
        room: "Room 204",
        floor: "Ground Floor"
    )
    
    NavigationStack {
        PaymentView(item: mockItem)
            .environmentObject(AppState())
    }
}

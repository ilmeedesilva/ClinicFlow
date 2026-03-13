import SwiftUI

struct AddMemberView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var gender: String = "Select Gender"
    @State private var contact: String = ""
    @State private var relationship: String = "Select Relationship"
    
    @State private var showSuccess: Bool = false
    
    let relationships = ["Father", "Mother", "Brother", "Sister", "Spouse", "Son", "Daughter", "Other"]
    let genders = ["Male", "Female", "Other"]
    let tealColor = Color(red: 0.18, green: 0.41, blue: 0.45)
    
    var isFormValid: Bool {
        !name.isEmpty && !age.isEmpty && gender != "Select Gender" && relationship != "Select Relationship"
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {

                HStack {
                    Button { dismiss() } label: {
                        Image(systemName: "chevron.left")
                            .font(.title3).bold().foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Add Member")
                            .font(.title).bold()
                        
                        Center {
                            ZStack(alignment: .bottomTrailing) {
                                Image( "Man")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .foregroundColor(.gray.opacity(0.3))
                                    .clipShape(Circle())
                                
                                Image(systemName: "plus.circle.fill")
                                    .symbolRenderingMode(.multicolor)
                                    .font(.system(size: 30))
                                    .background(Color.white.clipShape(Circle()))
                            }
                        }
                        
                        // MARK: Form Fields
                        VStack(alignment: .leading, spacing: 15) {
                            profileInputField(label: "Full Name", text: $name, placeholder: "Enter name")
                            
                            profileInputField(label: "Age", text: $age, placeholder: "Enter age")
                                .keyboardType(.numberPad)
                            
                            Text("Gender").font(.headline)
                            Menu {
                                ForEach(genders, id: \.self) { g in
                                    Button(g) { gender = g }
                                }
                            } label: {
                                groupFieldLabel(text: gender)
                            }
                            
                            profileInputField(label: "Contact Number", text: $contact, placeholder: "Enter number")
                                .keyboardType(.phonePad)
                            
                            Text("Relationship").font(.headline)
                            Menu {
                                ForEach(relationships, id: \.self) { rel in
                                    Button(rel) { relationship = rel }
                                }
                            } label: {
                                groupFieldLabel(text: relationship)
                            }
                        }
                        
                        Button {
                            saveMemberAction()
                        } label: {
                            Text("Save Member")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(isFormValid ? tealColor : Color.gray)
                                .cornerRadius(10)
                        }
                        .disabled(!isFormValid)
                        .padding(.top, 10)
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
            
            if showSuccess {
                SuccessOverlayView(
                    title: "Member Added",
                    subtitle: "\(name) has been added to your family list.",
                    buttonTitle: "Done"
                ) {
                    showSuccess = false
                    dismiss()
                }
            }
        }
    }

    
    func profileInputField(label: String, text: Binding<String>, placeholder: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label).font(.headline)
            TextField(placeholder, text: text)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(tealColor, lineWidth: 1))
        }
    }
    
    func groupFieldLabel(text: String) -> some View {
        HStack {
            Text(text)
                .foregroundColor(text.contains("Select") ? .gray : .black)
            Spacer()
            Image(systemName: "chevron.down")
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(tealColor, lineWidth: 1))
    }
    
    func saveMemberAction() {
        let newMember = FamilyMember(
            id: UUID(),
            name: name,
            age: Int(age) ?? 0,
            gender: gender,
            contact: contact,
            relationship: relationship,
            image: "Man"
        )
        
        appState.familyMembers.append(newMember)
        
        withAnimation {
            showSuccess = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                showSuccess = false
            }
            dismiss()
        }
    }
}

#Preview {
    AddMemberView()
        .environmentObject(AppState())
}

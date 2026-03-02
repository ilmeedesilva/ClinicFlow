import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var appState: AppState
    var member: FamilyMember
    @Environment(\.dismiss) var dismiss
    
    @State private var fullName: String = ""
    @State private var age: String = ""
    @State private var gender: String = "Male"
    @State private var contactNumber: String = ""
    @State private var relationship: String = ""
    
    @State private var profileImageName: String = "Man"
    @State private var showSuccess: Bool = false
    @State private var showImagePicker: Bool = false
    
    let tealColor = Color(red: 0.18, green: 0.41, blue: 0.45)
    
    var isFormValid: Bool {
        !fullName.isEmpty && !contactNumber.isEmpty
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
                        Text("Edit Profile")
                            .font(.title).bold()
                        
                        // MARK: Profile Image
                        Center {
                            ZStack(alignment: .bottomTrailing) {
                                Image(profileImageName)
                                    .resizable()
                                    .frame(width: 120, height: 120)
                                    .clipShape(Circle())
                                
                                Button {
                                    showImagePicker = true
                                } label: {
                                    Image(systemName: "pencil.circle.fill")
                                        .symbolRenderingMode(.multicolor)
                                        .font(.system(size: 30))
                                        .background(Color.white.clipShape(Circle()))
                                }
                            }
                        }
                        
                        // MARK: Form Fields
                        VStack(alignment: .leading, spacing: 15) {
                            profileInputField(label: "Full Name", text: $fullName, placeholder: member.name)
                            
                            profileInputField(label: "Age", text: $age, placeholder: "47")
                                .keyboardType(.numberPad)
                            
                            Text("Gender").font(.headline)
                            Menu {
                                Button("Male") { gender = "Male" }
                                Button("Female") { gender = "Female" }
                                Button("Other") { gender = "Other" }
                            } label: {
                                groupFieldLabel(text: gender)
                            }
                            
                            profileInputField(label: "Contact Number", text: $contactNumber, placeholder: "075 764 3484")
                                .keyboardType(.phonePad)
                            
                            Text("Relationship").font(.headline)
                            Menu {
                                Button("You") { relationship = "You" }
                                Button("Father") { relationship = "Father" }
                                Button("Mother") { relationship = "Mother" }
                                Button("Sister") { relationship = "Sister" }
                                Button("Brother") { relationship = "Brother" }
                                Button("Spouse") { relationship = "Spouse" }
                                Button("Son") { relationship = "Son" }
                                Button("Daughter") { relationship = "Daughter" }
                                Button("Other") { relationship = "Other" }
                            } label: {
                                groupFieldLabel(text: relationship.isEmpty ? "Select Relationship" : relationship)
                            }
                        }
                        
                        // MARK: Save Button
                        Button {
                            showSuccess = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                showSuccess = false
                                dismiss()
                            }
                        } label: {
                            Text("Save Changes")
                                .font(.headline).foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(isFormValid ? tealColor : Color.gray)
                                .cornerRadius(10)
                        }
                        .disabled(!isFormValid)
                        .padding(.top, 10)
                        
                        Text("My Appointments").font(.title3).bold().padding(.top, 10)
                        AppointmentCard()
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
            
            // Image Upload Popup
            if showImagePicker {
                ImageUploadPopupView(isPresented: $showImagePicker) {
                    profileImageName = "profile"
                    print("Simulated Image Saved")
                }
            }
            
            // Success Popup
            if showSuccess {
                SuccessOverlayView(
                    title: "Profile Updated",
                    subtitle: "Your changes have been saved successfully.",
                    buttonTitle: "Redirecting..."
                ) {
                    showSuccess = false
                    dismiss()
                }
            }
        }
        .onAppear {
            fullName = member.name
            age = "\(member.age)"
            gender = member.gender
            relationship = member.relationship
            contactNumber = member.contact
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
            Text(text).foregroundColor(.black)
            Spacer()
            Image(systemName: "chevron.down")
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(tealColor, lineWidth: 1))
    }
}

// MARK: Supporting Views

struct Center<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) { self.content = content() }
    var body: some View { HStack { Spacer(); content; Spacer() } }
}

struct AppointmentCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image("doctor4")
                    .resizable().frame(width: 50, height: 50).clipShape(Circle())
                VStack(alignment: .leading) {
                    Text("Dr. Joseph Brostito").font(.headline)
                    Text("Dental Specialist").font(.subheadline).foregroundColor(.blue)
                }
                Spacer()
                Text("Completed")
                    .font(.caption).bold().foregroundColor(.green)
                    .padding(5).background(Color.green.opacity(0.1)).cornerRadius(5)
            }
            Divider()
            HStack {
                Label("Sunday, 12 June", systemImage: "calendar")
                Spacer()
                Label("11:00 - 12:00 AM", systemImage: "clock")
            }
            .font(.caption).foregroundColor(.secondary)
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.blue.opacity(0.3), lineWidth: 1))
    }
}

#Preview {
    let mockMember = FamilyMember(
        id: UUID(),
        name: "John Dae",
        age: 30,
        gender: "Male",
        contact: "075 764 3484",
        relationship: "You",
        image: "person.circle.fill"
    )
    
    NavigationStack {
        EditProfileView(member: mockMember)
            .environmentObject(AppState())
    }
}

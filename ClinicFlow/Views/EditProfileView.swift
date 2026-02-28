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
    
    let tealColor = Color(red: 0.18, green: 0.41, blue: 0.45)
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Custom Header
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
                    
                    // MARK: - Profile Image
                    Center {
                        ZStack(alignment: .bottomTrailing) {
                            Image("Man")
                                .resizable()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                            
                            Image(systemName: "pencil.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 30))
                                .background(Color.white.clipShape(Circle()))
                        }
                    }
                    
                    // MARK: Form Fields
                    VStack(alignment: .leading, spacing: 15) {
                        profileInputField(label: "Full Name", text: $fullName, placeholder: member.name)
                        profileInputField(label: "Age", text: $age, placeholder: "47")
                        
                        Text("Gender").font(.headline)

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
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(tealColor, lineWidth: 1)
                            )
                        }
                        
                        profileInputField(label: "Contact Number", text: $contactNumber, placeholder: "075 764 3484")
                        
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
                            HStack {
                                Text(relationship.isEmpty ? "Select Relationship" : relationship)
                                    .foregroundColor(relationship.isEmpty ? .gray : .black)
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(tealColor, lineWidth: 1)
                            )
                        }
                    }
                    
                    // MARK: Save Button
                    Button {
                        
                    } label: {
                        Text("Save")
                            .font(.headline).foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(tealColor)
                            .cornerRadius(10)
                    }
                    .padding(.top, 10)
                    
                    // MARK: My Appointments
                    Text("My Appointments").font(.title3).bold().padding(.top, 10)
                    
                    AppointmentCard()
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        .onAppear { fullName = member.name }
    }
    
    func profileInputField(label: String, text: Binding<String>, placeholder: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label).font(.headline)
            TextField(placeholder, text: text)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(tealColor, lineWidth: 1))
        }
    }
}

struct Center<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) { self.content = content() }
    var body: some View { HStack { Spacer(); content; Spacer() } }
}

// Appointment Card Subview
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
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!,
        name: "John Dae",
        age: 30,
        gender: "Male",
        contact: "075 764 3484",
        relationship: "You",
        image: "person.circle.fill"
    )
    
   NavigationStack {
        EditProfileView(member: mockMember)
    }
}


import SwiftUI

// MARK: Data Model
struct FamilyMember: Identifiable {
    let id = UUID()
    let name: String
    let relationship: String
    let image: String
}

struct FamilyUsersView: View {
    @Environment(\.dismiss) var dismiss
    
    let familyMembers = [
        FamilyMember(name: "John Dae", relationship: "You", image: "person.circle.fill"),
        FamilyMember(name: "Kamal Silva", relationship: "Father", image: "person.circle.fill"),
        FamilyMember(name: "Amila Silva", relationship: "Mother", image: "person.circle.fill")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: Header
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Text("Family Users")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                
                Image(systemName: "chevron.left").opacity(0)
            }
            .padding()
            .background(Color(red: 0.18, green: 0.41, blue: 0.45))
            
            // MARK: - Family List
            List {
                ForEach(familyMembers) { member in
                    NavigationLink(destination: EditProfileView(member: member)){
                        HStack(spacing: 15) {
                            
                            Image(systemName: member.image)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color(red: 0.4, green: 0.6, blue: 1.0))
                            
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(member.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text(member.relationship)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .listStyle(.plain)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    FamilyUsersView()
}

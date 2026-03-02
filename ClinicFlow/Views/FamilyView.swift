import SwiftUI

struct FamilyUsersView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: Header
            HStack {
                Spacer()
                
                Text("Family Users")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
            .background(Color(red: 0.18, green: 0.41, blue: 0.45))
            
            // MARK: Family List
            List {
                ForEach(appState.familyMembers) { member in
                    NavigationLink {
                        EditProfileView(member: member)
                            .environmentObject(appState)
                    } label: {
                        HStack(spacing: 15) {
                            
                            Image(systemName: member.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color.blue)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(member.name)
                                    .font(.headline)
                                
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
    NavigationStack {
        FamilyUsersView()
            .environmentObject(AppState())
    }
}

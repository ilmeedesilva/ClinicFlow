import SwiftUI

struct FamilyUsersView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    
    @State private var selectedTab = 0
    
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
            
            
            // MARK: Segmented Tabs
            HStack(spacing: 0) {
                
                tabButton(title: "Family Users", index: 0)
                
                tabButton(title: "My Appointments", index: 1)
            }
            .padding(4)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.headerColor, lineWidth: 1)
            )
            .padding(.horizontal)
            .padding(.top, 10)
            
            
            // MARK: Content
            if selectedTab == 0 {
                familyUsersList
            } else {
                myAppointmentsView
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Components

extension FamilyUsersView {
    
    // Tab Button
    func tabButton(title: String, index: Int) -> some View {
        Button {
            withAnimation {
                selectedTab = index
            }
        } label: {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(selectedTab == index ? .white : .gray)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(
                    selectedTab == index ?
                    Color.headerColor :
                    Color.clear
                )
                .cornerRadius(16)
        }
    }
    
    
    // Family Users List
    var familyUsersList: some View {
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
                        
                        Spacer()
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .listStyle(.plain)
    }
    
    
    // My Appointments
    var myAppointmentsView: some View {

        MyAppointmentsView()
    }
    
}

#Preview {
    NavigationStack {
        FamilyUsersView()
            .environmentObject(AppState())
    }
}

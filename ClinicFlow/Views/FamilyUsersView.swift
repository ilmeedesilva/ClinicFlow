import SwiftUI

struct FamilyUsersView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            
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
            
            if selectedTab == 0 {
                familyUsersList
            } else {
                myAppointmentsView
            }
        }
        .navigationBarHidden(true)
    }
}

extension FamilyUsersView {
    
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
    
    // MARK: Family Users List
    var familyUsersList: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                ForEach(appState.familyMembers) { member in
                    NavigationLink {
                        EditProfileView(member: member)
                            .environmentObject(appState)
                    } label: {
                        VStack(spacing: 0) {
                            HStack(spacing: 15) {
                                Image(systemName: member.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color.blue)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(member.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    Text(member.relationship)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.gray.opacity(0.5))
                            }
                            .padding(.vertical, 15)
                            .padding(.horizontal)
                            
                            Divider()
                                .padding(.leading, 80)
                        }
                    }
                }
                
                NavigationLink {
                    AddMemberView()
                        .environmentObject(appState)
                } label: {
                    Text("Add New Member")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.headerColor)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.top, 40)
                .padding(.bottom, 30)
            }
        }
    }
    
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

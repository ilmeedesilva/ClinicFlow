import SwiftUI

struct AppointmentView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    var body: some View {
        VStack(spacing: 0) {
            
            AppHeader(title: "Book an Appointment")
            
            // MARK: - Content
            
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Medical Specialties")
                    .font(.title2)
                    .bold()
                
                Text("Wide selection of doctor's specialties")
                    .foregroundColor(.gray)
                
                // Search Box
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("search", text: $searchText)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.headerColor, lineWidth: 1)
                )
                
                ScrollView {
                    
                    specialtyRow(
                        title: "Ear, Nose & Throat",
                        image: "ear"
                    )
                    
                    specialtyRow(
                        title: "Psychiatrist",
                        image: "brain"
                    )
                    
                    specialtyRow(
                        title: "Dentist",
                        image: "tooth"
                    )
                    
                    specialtyRow(
                        title: "Dermatology",
                        image: "hand"
                    )
                }
            }
            .padding()
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Specialty Row
    
    func specialtyRow(title: String, image: String) -> some View {
        
        NavigationLink {
            DoctorListView(specialty: title)
        } label: {
            
            HStack(spacing: 16) {
                
                // Icon Circle
                ZStack {
                    
                    
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("Wide selection of doctor's specialties")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 10)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack { AppointmentView() }
}

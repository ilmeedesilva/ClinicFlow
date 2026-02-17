import SwiftUI

struct DoctorListView: View {
    
    let specialty: String
        @State private var searchText = ""
        
        var body: some View {
            VStack(spacing: 0) {
                
                AppHeader(title: specialty)
                
                VStack {
                    
                    // Search Box
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search Doctor", text: $searchText)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.headerColor, lineWidth: 1)
                    )
                    .padding()
                    
                    ScrollView {
                        ForEach(getDoctors(), id: \.name) { doctor in
                            
                            NavigationLink {
                                let item = BookableItem(
                                        serviceType: .doctor,
                                        title: doctor.name,
                                        subtitle: doctor.subtitle,
                                        price: 2500,
                                        image: doctor.image
                                    )
                                    
                                    DateTimeSelectionView(item: item)
                            } label: {
                                DoctorRow(
                                    imageName: doctor.image,
                                    name: doctor.name,
                                    subtitle: doctor.subtitle,
                                    price: doctor.price
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    
    // MARK: - Hardcoded Doctors
    
    func getDoctors() -> [Doctor] {
        
        switch specialty {
            
        case "Ear, Nose & Throat":
            return [
                Doctor(image: "doctor1", name: "Dr. Patricia Ahoy",
                       subtitle: "Ear, Nose & Throat specialist", price: "Rs. 2500.00"),
                Doctor(image: "doctor2", name: "Dr. Stone Gaze",
                       subtitle: "Ear, Nose & Throat Surgeon", price: "Rs. 2700.00"),
                Doctor(image: "doctor3", name: "Dr. Wahyu",
                       subtitle: "Ear, Nose & Throat Consultant", price: "Rs. 2600.00"),
                Doctor(image: "doctor4", name: "Dr. Olivia Mind",
                       subtitle: "Ear, Nose & Throat Consultant", price: "Rs. 3000.00")
               
            ]
            
        case "Psychiatrist":
            return [
                Doctor(image: "doctor4", name: "Dr. Olivia Mind",
                       subtitle: "Psychiatrist", price: "Rs. 3000.00"),
                Doctor(image: "doctor5", name: "Dr. James Brain",
                       subtitle: "Mental Health Specialist", price: "Rs. 3200.00")
            ]
            
        case "Dentist":
            return [
                Doctor(image: "doctor1", name: "Dr. White Smile",
                       subtitle: "Dental Surgeon", price: "Rs. 2000.00"),
                Doctor(image: "doctor2", name: "Dr. Pearl Shine",
                       subtitle: "Orthodontist", price: "Rs. 2300.00")
            ]
            
        case "Dermatology":
            return [
                Doctor(image: "doctor3", name: "Dr. Skin Care",
                       subtitle: "Dermatologist", price: "Rs. 2800.00"),
                Doctor(image: "doctor4", name: "Dr. Glow Face",
                       subtitle: "Skin Specialist", price: "Rs. 2900.00")
            ]
            
        default:
            return []
        }
    }
}

#Preview("ENT Specialty") {
    NavigationStack { DoctorListView(specialty: "Ear, Nose & Throat") }
}

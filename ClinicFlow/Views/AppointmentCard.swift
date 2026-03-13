import SwiftUI

struct AppointmentCard: View {
    
    let imageName: String
    let doctor: String
    let specialty: String
    let date: String
    let time: String
    let status: String
    let statusColor: Color
    var cancelAction: (() -> Void)? = nil
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                
                Image(imageName)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(doctor)
                        .font(.headline)
                    
                    Text(specialty)
                        .foregroundColor(.blue)
                        .font(.subheadline)
                }
                
                Spacer()
                
                Text(status)
                    .font(.caption)
                    .bold()
                    .foregroundColor(statusColor)
                    .padding(6)
                    .background(
                        (statusColor.opacity(0.15)
                    )
                    .cornerRadius(6)
           ) }
            
            Divider()
            
            HStack {
                Label(date, systemImage: "calendar")
                Spacer()
                Label(time, systemImage: "clock")
            }
            .font(.caption)
            .foregroundColor(.secondary)
            
            
            if status == "In Progress" {
                Button {
                    cancelAction?()
                } label: {
                    Text("Cancel Booking")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.headerColor)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.blue.opacity(0.3))
        )
    }
}

#Preview {
    VStack(spacing: 20) {
        AppointmentCard(
            imageName: "doctor2",
            doctor: "Dr. Joseph Brostito",
            specialty: "Dental Specialist",
            date: "Sunday, 12 June",
            time: "11:00 - 12:00 AM",
            status: "In Progress",
            statusColor: .blue
        )
        
        AppointmentCard(
            imageName: "doctor3",
            doctor: "Dr. Saman Fernando",
            specialty: "Dental Specialist",
            date: "Sunday, 14 June",
            time: "11:00 - 12:00 AM",
            status: "Cancelled",
            statusColor: .red 
        )
    }
}

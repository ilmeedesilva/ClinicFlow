import SwiftUI

struct BookingSummaryView: View {
    
    let item: BookableItem
    let selectedDay: String
    let selectedTime: String
    
    var body: some View {
        VStack(spacing: 0) {
            
            AppHeader(title: "Make Appointment")
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: Doctor Info
                    HStack(spacing: 12) {
                        Image(item.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title)
                                .font(.system(size: 18, weight: .bold))
                            
                            Text(item.subtitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Text("Rs. \(Int(item.price)).00")
                                .font(.system(size: 18, weight: .bold))
                        }
                    }
                    
                    Divider()
                    
                    // MARK: Appointments & Avg Time
                    HStack {
                        InfoStatView(
                            icon: "appointment-icon",
                            title: "Appointments",
                            value: "14"
                        )
                        
                        Divider()
                            .frame(height: 50)
                        
                        InfoStatView(
                            icon: "clock-icon",
                            title: "Avg Est. time",
                            value: "15 minutes"
                        )
                    }
                    .padding(.vertical, 4)

                    
                    Divider()
                    
                    // MARK: Queue
                    AppointmentQueueView()
                    
                    Divider()
                    
                    // MARK: Location
                    LocationMapView()
                    
                    Spacer(minLength: 40)
                }
                .padding()
            }
            
            // MARK: Bottom Button
            NavigationLink {
                PaymentView(item: item)
            } label: {
                Text("Make Appointment")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.headerColor)
                    .cornerRadius(14)
                    .padding()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview("Booking Summary") {
    let mockItem = BookableItem(
        serviceType: .doctor,
        title: "Dr. Patricia Ahoy",
        subtitle: "ENT Specialist",
        price: 2500,
        image: "doctor1"
    )
    return NavigationStack {
        BookingSummaryView(
            item: mockItem,
            selectedDay: "Wed 10",
            selectedTime: "11:00"
        )
    }
}

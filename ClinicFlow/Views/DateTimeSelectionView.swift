import SwiftUI

struct DateTimeSelectionView: View {
    
    let item: BookableItem
    
    @State private var selectedDay = "10"
    @State private var selectedTime = "11:00"
    
    var body: some View {
        VStack(spacing: 0) {
            
            AppHeader(title: "Make an Appointment")
            
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    
                    // Title
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Select your Visit Date & Time")
                            .font(.title2)
                            .bold()
                        
                        Text("You can choose the date and time from the available doctor's schedule")
                            .foregroundColor(.gray.opacity(0.7))
                    }
                    
                    // Choose Day
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Choose Day, Feb 2026")
                            .bold()
                        
                        HStack(spacing: 16) {
                            dayBox(day: "Wed", date: "10")
                            dayBox(day: "Thu", date: "11")
                            dayBox(day: "Fri", date: "12")
                        }
                    }
                    
                    // Morning
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Morning Set")
                            .bold()
                        
                        HStack(spacing: 12) {
                            timeBox("10:00", isAvailable: false)   // Disabled
                            timeBox("11:00", isAvailable: true)
                            timeBox("12:00", isAvailable: false)   // Disabled
                            timeBox("13:30", isAvailable: true)
                        }
                    }
                    
                    // Afternoon
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Afternoon Set")
                            .bold()
                        
                        HStack(spacing: 12) {
                            timeBox("18:00", isAvailable: false)   // Disabled
                            timeBox("19:00", isAvailable: true)
                            timeBox("20:00", isAvailable: true)
                        }
                    }
                    
                    Spacer(minLength: 40)
                    
                    NavigationLink {
                        BookingSummaryView(
                            item: item,
                            selectedDay: selectedDay,
                            selectedTime: selectedTime
                        )
                    } label: {
                        Text("Confirm")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.headerColor)
                            .cornerRadius(14)
                    }
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Day Box
    
    func dayBox(day: String, date: String) -> some View {
        
        Button {
            selectedDay = date
        } label: {
            VStack(spacing: 6) {
                Text(day)
                    .font(.system(size: 14))
                
                Text(date)
                    .font(.system(size: 20, weight: .bold))   // Bold date
            }
            .foregroundColor(selectedDay == date ? .white : .black)
            .frame(width: 80, height: 80)
            .background(
                selectedDay == date
                ? Color.headerColor
                : Color.lightGrayBG
            )
            .cornerRadius(16)
        }
    }
    
    // MARK: - Time Box
    
    func timeBox(_ value: String, isAvailable: Bool) -> some View {
        
        Button {
            if isAvailable {
                selectedTime = value
            }
        } label: {
            Text(value)
                .font(.system(size: 14))
                .foregroundColor(
                    !isAvailable
                    ? .gray.opacity(0.5)
                    : (selectedTime == value ? .white : .black)
                )
                .padding(.horizontal, 18)
                .padding(.vertical, 10)
                .background(
                    !isAvailable
                    ? Color.disabledGray
                    : (selectedTime == value
                        ? Color.headerColor
                        : Color.lightGrayBG)
                )
                .cornerRadius(20)
        }
        .disabled(!isAvailable)
    }
}


#Preview("Date & Time Selection") {
    let mockItem = BookableItem(
        serviceType: .doctor,
        title: "Dr. Patricia Ahoy",
        subtitle: "ENT Specialist",
        price: 2500.0,
        image: "doctor1",
        room: "A12",
        floor: "3"
    )
    NavigationStack {
        DateTimeSelectionView(item: mockItem)
    }
}


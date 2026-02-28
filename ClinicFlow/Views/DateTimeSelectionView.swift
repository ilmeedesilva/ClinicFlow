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
                    
                    // MARK: Doctor Details
                    VStack(alignment: .leading, spacing: 16) {
                        
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
                            }
                            
                            Spacer()
                        }
                        
                        Divider()
                        
                        // MARK: Rating
                        HStack {
                            Text("Rating")
                                .font(.headline)
                            
                            Spacer()
                            
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orange)
                                Text("4.5")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Divider()
                        
                        // MARK: Biography
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Biography")
                                .font(.headline)
                            
                            Text("""
Dr. Nadeesha Senanayake is a skilled ENT specialist who treats sinus, allergy, hearing, and throat conditions. With a caring approach and years of clinical experience, she helps patients breathe easier and feel better every day.
""")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .lineSpacing(4)
                        }
                    }
                    
                    Divider()
                    
                    // MARK: Date & Time Section Title
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Select your Date & Time")
                            .font(.title3)
                            .bold()
                        
                        Text("You can choose the date and time from the available doctor's schedule")
                            .font(.subheadline)
                            .foregroundColor(.gray.opacity(0.7))
                    }
                    
                    // MARK: Choose Day
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Choose Day, Feb 2026")
                            .bold()
                        
                        HStack(spacing: 16) {
                            dayBox(day: "Wed", date: "10")
                            dayBox(day: "Thu", date: "11")
                            dayBox(day: "Fri", date: "12")
                        }
                    }
                    
                    // MARK: Morning Set
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Morning Set")
                            .bold()
                        
                        HStack(spacing: 12) {
                            timeBox("10:00", isAvailable: false)
                            timeBox("11:00", isAvailable: true)
                            timeBox("12:00", isAvailable: false)
                            timeBox("13:30", isAvailable: true)
                        }
                    }
                    
                    // MARK: Afternoon Set
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Afternoon Set")
                            .bold()
                        
                        HStack(spacing: 12) {
                            timeBox("18:00", isAvailable: false)
                            timeBox("19:00", isAvailable: true)
                            timeBox("20:00", isAvailable: true)
                        }
                    }
                    
                    Spacer(minLength: 40)
                    
                    // MARK: Confirm Button
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
    
    
    // MARK: Day Box
    func dayBox(day: String, date: String) -> some View {
        Button {
            selectedDay = date
        } label: {
            VStack(spacing: 6) {
                Text(day)
                    .font(.system(size: 14))
                
                Text(date)
                    .font(.system(size: 20, weight: .bold))
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
    
    
    // MARK: Time Box
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


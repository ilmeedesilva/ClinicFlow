import SwiftUI

struct AppointmentQueueView: View {
    
    @State private var selectedNumber = 14
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Appointment Queue")
                .font(.headline)
            
            HStack(spacing: 16) {
                queueBox(14)
                queueBox(15)
                queueBox(16)
                queueBox(17)
            }
        }
    }
    
    func queueBox(_ number: Int) -> some View {
        Button {
            selectedNumber = number
        } label: {
            Text("\(number)")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(selectedNumber == number ? .white : .black)
                .frame(width: 70, height: 60)
                .background(
                    selectedNumber == number
                    ? Color.headerColor
                    : Color.lightGrayBG
                )
                .cornerRadius(16)
        }
    }
}

import SwiftUI

// MARK: Enum Definition 
enum QueueStatus: String {
    case completed = "Completed"
    case inProgress = "In Progress"
    case pending = "Pending"
    
    var color: Color {
        switch self {
        case .completed: return .green
        case .inProgress: return .blue
        case .pending: return .orange
        }
    }
}

struct QueueView: View {
    
    @Environment(\.dismiss) var dismiss
    
    
    let headerColor = Color(red: 0.18, green: 0.41, blue: 0.45)
    
    var body: some View {
        VStack(spacing: 0) {
            
            AppHeader(title: "Queue Status")
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Your Appointments")
                        .font(.title3)
                        .bold()
                        .padding(.top)
                    
                    // Appointment Cards
                    statusCard(
                        title: "Channeling",
                        queueNo: "11",
                        status: .completed,
                        timeInfo: "Completed at 9:15 AM",
                        icon: "check"
                    )
                    
                    statusCard(
                        title: "Consultation",
                        queueNo: "11",
                        status: .inProgress,
                        timeInfo: "Est. wait time: 5 mins",
                        icon: "in-progress"
                    )
                    
                    statusCard(
                        title: "Laboratory",
                        queueNo: "11",
                        status: .pending,
                        timeInfo: "Est. wait time: 15 mins",
                        icon: "pending"
                    )
                    
                    statusCard(
                        title: "Pharmacy",
                        queueNo: "11",
                        status: .pending,
                        timeInfo: "Est. wait time: 25 mins",
                        icon: "pending"
                    )
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
    
    
    
    func statusCard(title: String, queueNo: String, status: QueueStatus, timeInfo: String, icon: String) -> some View {
        VStack(spacing: 12) {
            HStack(alignment: .top, spacing: 15) {
                ZStack {
                    Circle()
                        .fill(status.color.opacity(0.15))
                        .frame(width: 50, height: 50)
                    
                    customIcon(icon)
                        .foregroundColor(status.color)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("Queue No: \(queueNo)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Text(status.rawValue)
                    .font(.caption2)
                    .bold()
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .foregroundColor(status.color)
                    .overlay(
                        Capsule().stroke(status.color, lineWidth: 1)
                    )
            }
            
            Divider()
            
            HStack(spacing: 8) {
                Image(systemName: status == .completed ? "checkmark.circle" : "clock")
                    .foregroundColor(status.color)
                
                Text(timeInfo)
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.teal.opacity(0.3), lineWidth: 1)
        )
    }

    func customIcon(_ name: String) -> some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .frame(width: 25, height: 25)
    }
}

#Preview {
    QueueView()
}

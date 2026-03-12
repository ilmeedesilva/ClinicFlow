import SwiftUI

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
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    
    @State private var rotationAngle: Double = 0.0
    
    let appointmentNames = ["Channeling", "Consultation", "Laboratory", "Pharmacy"]
    let iconNames = ["check", "in-progress", "pending", "pending"]
    
    var body: some View {
        VStack(spacing: 0) {
            AppHeader(title: "Queue Status", showBackButton: true)
            
            if appState.hasActiveAppointment {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Your Appointments")
                            .font(.title3)
                            .bold()
                            .padding(.top)
                        
                        ForEach(0..<appointmentNames.count, id: \.self) { index in
                            statusCard(
                                title: appointmentNames[index],
                                queueNo: appState.hasActiveAppointment ? "\(appState.queueNumber)" : "--",
                                status: getStatus(for: index),
                                timeInfo: getTimeInfo(for: index),
                                icon: iconNames[index],
                                isCurrent: index == appState.currentQueueStep
                            )
                            .onTapGesture {
                                if index == appState.currentQueueStep && appState.currentQueueStep < (appointmentNames.count - 1) {
                                    withAnimation(.spring()) {
                                        appState.currentQueueStep += 1
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
            }else {
                VStack(spacing: 20) {
                    Spacer()
                    Image(systemName: "clock.badge.checkmark")
                        .font(.system(size: 50))
                        .foregroundColor(.gray.opacity(0.5))
                    
                    Text("No Active Queue")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text("Your live progress will appear here once you book an appointment.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                rotationAngle = 360
            }
        }
    }
    
    // MARK: - Helper Logic
    
    private func getStatus(for index: Int) -> QueueStatus {

        if index == 0 {
            return appState.completedServices.contains(.doctor) ? .completed : .pending
        }

        if index == 1 {
            if appState.completedServices.contains(.laboratory) {
                return .completed
            }
            if appState.completedServices.contains(.doctor) {
                return .inProgress
            }
            return .pending
        }

        if index == 2 {
            if appState.completedServices.contains(.pharmacy) {
                return .completed
            }
            if appState.completedServices.contains(.laboratory) {
                return .inProgress
            }
            return .pending
        }

        return .pending
    }
    
    private func getTimeInfo(for index: Int) -> String {
        
        let status = getStatus(for: index)
        
        switch status {
        case .completed:
            return "Step Completed"
            
        case .inProgress:
            return "Estimated wait: 5 mins"
            
        case .pending:
            return "Waiting for previous step"
        }
    }

    // MARK: - Card Component
    
    func statusCard(title: String, queueNo: String, status: QueueStatus, timeInfo: String, icon: String, isCurrent: Bool) -> some View {
        VStack(spacing: 12) {
            HStack(alignment: .top, spacing: 15) {
                ZStack {
                    Circle()
                        .fill(status.color.opacity(0.15))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: isCurrent ? "arrow.clockwise" : (status == .completed ? "checkmark.circle" : "hourglass"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(status.color)
                        .rotationEffect(.degrees(isCurrent ? rotationAngle : 0))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("Queue No: \(queueNo)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text(status.rawValue)
                    .font(.caption2)
                    .bold()
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .foregroundColor(status.color)
                    .overlay(
                        Capsule().stroke(status.color, lineWidth: 1)
                    )
            }
            
            Divider()
            
            HStack(spacing: 8) {
                Image(systemName: status == .completed ? "checkmark.circle.fill" : "clock")
                    .foregroundColor(status.color)
                
                Text(timeInfo)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Preview
#Preview {
    let mockState = AppState()
    mockState.hasActiveAppointment = true
    mockState.queueNumber = 12
    mockState.currentQueueStep = 1
    
    return QueueView()
        .environmentObject(mockState)
}

import SwiftUI

struct QueueStatusView: View {
    
    enum QueueStage {
        case awaiting
        case yourTurn
        case completed
    }
    
    @EnvironmentObject var appState: AppState
    
    @Environment(\.dismiss) var dismiss
    @State private var stage: QueueStage

    init(stage: QueueStage = .awaiting) {
        _stage = State(initialValue: stage)
    }

    
    var body: some View {
        ZStack {
            
            // Background
            Color(hex: "#68B2A1")
                .ignoresSafeArea()
            
            VStack {
                
                Spacer(minLength: 80)
                
                ZStack {
                    
                    VStack(spacing: 22) {
                        
                        Spacer().frame(height: 50)
                        
                        Text(titleText)
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Spacer().frame(height: 20)
                        
                        // Queue Info
                        VStack(spacing: 6) {
                            Image("ticket")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                            
                            Text("Your Queue Number")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Text("14")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                        Spacer().frame(height: 20)
                        
                        stageContent
                        
                        Spacer()
                        
                        Button {
                            appState.hasActiveAppointment = false
                            dismiss()

                        } label: {
                            Text("Back to home")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "#2D6876"))
                                .cornerRadius(14)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                    
                    // Floating Icon
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .frame(width: 90, height: 90)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(hex: "#2D6876"), lineWidth: 6)
                                )
                            
                            Image(stageIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(Color(hex: "#2D6876"))
                        }
                        .offset(y: -50)
                        
                        Spacer()
                    }
                }
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
        .onAppear {
            startQueueFlow()
        }
    }
    
    // MARK: Dynamic Content
    
    var titleText: String {
        switch stage {
        case .awaiting:
            return "Awaiting Appointment"
        case .yourTurn:
            return "Your Turn"
        case .completed:
            return "Consultation Completed"
        }
    }
    
    var stageIcon: String {
        switch stage {
        case .awaiting:
            return "ready"
        case .yourTurn:
            return "success"
        case .completed:
            return "success"
        }
    }

    
    @ViewBuilder
    var stageContent: some View {
        switch stage {
            
        case .awaiting:
            VStack(spacing: 12) {
                circularProgress(current: 11)
                
                Text("Estimated waiting time 30 minutes")
                    .font(.caption)
                
                Text("Wednesday, 15 Feb")
                    .font(.caption)
            }
            
        case .yourTurn:
            VStack(spacing: 12) {
                circularProgress(current: 14)
                
                Text("Please visit the doctor")
                    .font(.caption)
                
                Text("Ground Floor, Room No 204")
                    .font(.caption)
                
                Text("Wednesday, 15 Feb")
                    .font(.caption)
            }
            
        case .completed:
            VStack(spacing: 12) {
                circularCheck()
                
                Text("Your appointment has been completed.")
                    .font(.caption)
                
                Text("Thank you for your cooperation.")
                    .font(.caption)
            }
        }
    }
    
    // MARK: Circular Progress
    
    func circularProgress(current: Int) -> some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 12)
                .frame(width: 120, height: 120)
            
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(Color(hex: "#2D6876"), lineWidth: 12)
                .rotationEffect(.degrees(-90))
                .frame(width: 120, height: 120)
            
            Text("\(current)")
                .font(.title)
                .fontWeight(.bold)
        }
    }
    
    func circularCheck() -> some View {
        ZStack {
            Circle()
                .stroke(Color(hex: "#2D6876"), lineWidth: 12)
                .frame(width: 120, height: 120)
            
            Image(systemName: "checkmark")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(Color(hex: "#2D6876"))
        }
    }
    
    // MARK: Auto Flow
    
    func startQueueFlow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            stage = .yourTurn
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                stage = .completed
            }
        }
    }
}

#Preview("Awaiting") {
    QueueStatusView(stage: .awaiting)
}

#Preview("Your Turn") {
    QueueStatusView(stage: .yourTurn)
}

#Preview("Completed") {
    QueueStatusView(stage: .completed)
        .environmentObject(AppState())
}



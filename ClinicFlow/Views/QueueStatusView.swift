import SwiftUI

struct QueueStatusView: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            
            // MARK: Background
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
                        
                        // MARK: Queue Info
                        VStack(spacing: 6) {
                            
                            Image("ticket")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                            
                            Text("Your Queue Number")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Text("\(appState.queueNumber)")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                        Spacer().frame(height: 20)
                        
                        stageContent
                        
                        Spacer()
                        
                        Button {
                            resetFlow()
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
                    
                    // MARK: Floating Icon
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
        .fullScreenCover(isPresented: $appState.shouldNavigateToPharmacyPayment) {
            PharmacyPaymentReadyView()
                .environmentObject(appState)
        }

    }


    
    // MARK: Dynamic Content
    
    var titleText: String {
        
        switch appState.currentStage {
            
        case .awaiting:
            return "Awaiting Appointment"
            
        case .yourTurn:
            return "Your Turn"
            
        case .completed:
            
            switch appState.currentItem?.serviceType {
            case .doctor:
                return "Consultation Completed"
            case .laboratory:
                return "Laboratory Service Completed"
            case .pharmacy:
                return "Medicine Collection Completed"
            default:
                return "Completed"
            }
        }
    }

    
    var stageIcon: String {
        
        switch appState.currentStage {
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
        
        switch appState.currentStage {
            
        case .awaiting:
            VStack(spacing: 12) {
                
                circularProgress(current: appState.queueNumber - 3)
                
                Text("Estimated waiting time 30 minutes")
                    .font(.caption)
                
                Text("Wednesday, 15 Feb")
                    .font(.caption)
            }
            
        case .yourTurn:
            VStack(spacing: 12) {
                
                circularProgress(current: appState.queueNumber)
                
                if let item = appState.currentItem {
                    Text("Please visit")
                        .font(.caption)
                    
                    Text("\(item.floor), \(item.room)")
                        .font(.caption)
                }
                
                Text("Wednesday, 15 Feb")
                    .font(.caption)
            }
            
        case .completed:
            VStack(spacing: 12) {
                
                circularCheck()
                
                if let item = appState.currentItem {
                    Text("\(completionMessage(for: item.serviceType))")
                        .font(.caption)
                }
                
                Text("Thank you for your cooperation.")
                    .font(.caption)
            }
        }
    }

    func completionMessage(for type: ServiceType) -> String {
        switch type {
        case .doctor:
            return "Your appointment has been completed."
        case .laboratory:
            return "Your laboratory visit has been completed successfully."
        case .pharmacy:
            return "Your medicine collection has been completed."
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
        
        guard let item = appState.currentItem else { return }
        
        // PHARMACY FLOW
        if item.serviceType == .pharmacy {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                appState.shouldNavigateToPharmacyPayment = true
            }
            
            return
        }
        
        // DOCTOR & LAB FLOW
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            appState.currentStage = .yourTurn
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                appState.currentStage = .completed
            }
        }
    }

    
    func resetFlow() {
        appState.hasActiveAppointment = false
        appState.currentStage = .awaiting
        dismiss()
    }


}

#Preview {
    
    let state = AppState()
    state.hasActiveAppointment = true
    state.queueNumber = 10
    state.currentStage = .awaiting
    state.currentItem = BookableItem(
        serviceType: .laboratory,
        title: "Complete Blood Count",
        subtitle: "Full blood cell analysis",
        price: 800,
        image: "BT",
        room: "Room 12",
        floor: "First Floor"
    )
    
    return QueueStatusView()
        .environmentObject(state)
}




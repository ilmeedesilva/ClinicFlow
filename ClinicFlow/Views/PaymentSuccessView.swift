import SwiftUI

struct PaymentSuccessView: View {
    
    let item: BookableItem
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        
        ZStack {
            
            Color(Color.successBackround)
                .ignoresSafeArea()
            
            VStack {
                
                Spacer(minLength: 80)
                
                ZStack {
                    
                    VStack(spacing: 28) {
                        
                        Spacer().frame(height: 50)
                        
                        Text("You have successfully made")
                            .font(.title3)
                        
                        Text("an appointment")
                            .font(.title3)
                        
                        // Dynamic Service Image
                        Image(item.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        VStack(spacing: 4) {
                            Text(item.title)
                                .font(.headline)
                            
                            Text(item.subtitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer().frame(height: 10)
                        
                        // MARK: Dynamic Appointment Details
                       
                            
                            HStack(alignment: .center, spacing: 12) {
                                
                                Image("appointment-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 28, height: 28)
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    
                                    Text("Appointment")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    Text("No \(appState.queueNumber)")
                                                .fontWeight(.bold)
                                    
                                    if let item = appState.currentItem {
                                                Text("\(item.room)")
                                                    .fontWeight(.bold)
                                            }
                                    
                                    Text("10 Feb 2026, 11:00")
                                                .fontWeight(.bold)
                                }
                            }
                            .padding(.top, 10)
                    
                        
                        Spacer()
                        
                        Button {
                            appState.currentItem = item
                                appState.hasActiveAppointment = true
                                appState.currentStage = .awaiting
                                
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
                    
                    // Floating Success Icon
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .frame(width: 90, height: 90)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(hex: "#2D6876"), lineWidth: 6)
                                )
                            
                            Image("success")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        }
                        .offset(y: -45)
                        
                        Spacer()
                    }
                }
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
    }
}

#Preview("Doctor Success") {
    
    let state = AppState()
    
    state.queueNumber = 14
    state.currentItem = BookableItem(
        serviceType: .doctor,
        title: "Dr. Patricia Ahoy",
        subtitle: "ENT Specialist",
        price: 2500,
        image: "doctor1",
        room: "Room 204",
        floor: "Ground Floor"
    )
    state.hasActiveAppointment = true
    state.currentStage = .awaiting
    
    return PaymentSuccessView(
        item: state.currentItem!
    )
    .environmentObject(state)
}

#Preview("Lab Success") {
    
    let state = AppState()
    
    state.queueNumber = 11
    state.currentItem = BookableItem(
        serviceType: .laboratory,
        title: "Complete Blood Count",
        subtitle: "Full blood analysis",
        price: 800,
        image: "BT",
        room: "Room 12",
        floor: "First Floor"
    )
    state.hasActiveAppointment = true
    state.currentStage = .awaiting
    
    return PaymentSuccessView(
        item: state.currentItem!
    )
    .environmentObject(state)
}

#Preview("Pharmacy Success") {
    
    let state = AppState()
    
    state.queueNumber = 7
    state.currentItem = BookableItem(
        serviceType: .pharmacy,
        title: "Prescription Medicines",
        subtitle: "Uploaded Prescription",
        price: 1500,
        image: "pharmacy",
        room: "Counter 3",
        floor: "Ground Floor"
    )
    state.hasActiveAppointment = true
    state.currentStage = .awaiting
    
    return PaymentSuccessView(
        item: state.currentItem!
    )
    .environmentObject(state)
}


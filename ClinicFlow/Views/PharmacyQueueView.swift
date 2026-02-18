import SwiftUI

struct PharmacyQueueView: View {
    
    let item: BookableItem
    
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedQueue = 10
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // MARK: Header
            AppHeader(title: "Pharmacy Queue")
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: Success Title
                    Text("Prescription submitted")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("successfully")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Divider()
                    
                    // MARK: Appointment + Avg Time
                    HStack {
                        
                        HStack(spacing: 8) {
                            Image("ticket")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28)
                            
                            VStack(alignment: .leading) {
                                Text("Your Queue Number")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Text("\(selectedQueue)")
                                    .font(.headline)
                            }
                        }
                        
                        Spacer()
                        
                        Divider()
                            .frame(height: 40)
                        
                        Spacer()
                        
                        HStack(spacing: 8) {
                            Image("clock-icon")
                            
                            VStack(alignment: .leading) {
                                Text("Avg Est. time")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Text("30 minutes")
                                    .font(.headline)
                            }
                        }
                    }
                    
                    Divider()
                    
                    // MARK: Appointment Queue Row (ADDED as requested)
                    AppointmentQueueView()
                    
                    Divider()
                    
                    // MARK: Location
                    LocationMapView()
                    
                    Spacer(minLength: 40)
                }
                .padding()
            }
            
            // MARK: Bottom Button
            Button {
                // Activate queue in home
                appState.hasActiveAppointment = true
                appState.queueNumber = selectedQueue
                appState.currentItem = item
                dismiss()
            } label: {
                Text("Back to home")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#2D6876"))
                    .cornerRadius(14)
                    .padding()
            }
        }
        .navigationBarHidden(true)
    }
    
    
    // MARK: Queue Box
    func queueBox(_ number: Int) -> some View {
        Button {
            selectedQueue = number
        } label: {
            Text("\(number)")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(selectedQueue == number ? .white : .black)
                .frame(width: 70, height: 60)
                .background(
                    selectedQueue == number
                    ? Color.headerColor
                    : Color.lightGrayBG
                )
                .cornerRadius(16)
        }
    }
}


#Preview("Pharmacy Queue") {
    
    let state = AppState()
    
    return NavigationStack {
        PharmacyQueueView(
            item: BookableItem(
                serviceType: .pharmacy,
                title: "Prescription Order",
                subtitle: "Medicine Collection",
                price: 0,
                image: "pharmacy-icon",
                room: "Counter 03",
                floor: "First Floor"
            )
        )
    }
    .environmentObject(state)
}

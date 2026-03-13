import SwiftUI

struct PharmacyQueueView: View {
    
    let item: BookableItem
    
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedQueue = 10
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            AppHeader(title: "Pharmacy Queue")
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    Text("Prescription submitted")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("successfully")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Divider()

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
                    
                    LocationMapView()
                    
                    Spacer(minLength: 40)
                }
                .padding()
            }
            
            Button {
                appState.hasActiveAppointment = true
                appState.queueNumber = selectedQueue
                appState.currentItem = item
                appState.selectedTab = 0
                appState.shouldReturnToHome = true 
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
                price: 800.00,
                image: "pharmacy-icon",
                room: "Counter 03",
                floor: "First Floor"
            )
        )
    }
    .environmentObject(state)
}

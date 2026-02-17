import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 0) {
            
            if appState.hasActiveAppointment {
                
                // MARK: Queue Header Version
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text("Welcome!")
                        .font(.system(size: 28, weight: .bold))
                    
                    Text("May you always in a good condition")
                        .foregroundColor(.gray)
                    
                    NavigationLink {
                        QueueStatusView()
                    } label: {
                        queueBox
                    }
                    .buttonStyle(.plain)

                }
                .padding()
                
            } else {
                
                // MARK: Normal Header With Image
                ZStack(alignment: .bottomLeading) {
                    
                    Image("Hospitalimg")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 280)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 30)
                        )
                        .ignoresSafeArea(edges: .top)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Welcome!")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("May you always in a good condition")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
            
            ScrollView {
                VStack(spacing: 16) {
                    
                    HStack(spacing: 16) {
                        
                        NavigationLink {
                            AppointmentView()
                        } label: {
                            HomeCard(
                                imageName: "homecard-docimg",
                                title: "Doctor/\nConsultation",
                                subtitle: "Find a Doctor or specialist",
                                background: Color(hex: "#E2EAFF")
                            )
                        }
                        
                        NavigationLink {
                            Text("Queue Screen")
                        } label: {
                            HomeCard(
                                imageName: "homecard-queueimg",
                                title: "Queue Status",
                                subtitle: "Monitor your visit progress",
                                background: Color(hex: "#EDFCF2")
                            )
                        }
                    }
                    
                    HStack(spacing: 16) {
                        
                        NavigationLink {
                            Text("Lab Flow")
                        } label: {
                            HomeCard(
                                imageName: "homecard-labimg",
                                title: "Request\nLaboratory",
                                subtitle: "Get your lab reports",
                                background: Color(hex: "#FEF6EE")
                            )
                        }
                        
                        NavigationLink {
                            Text("Pharmacy Flow")
                        } label: {
                            HomeCard(
                                imageName: "homecard-pharmacyimg",
                                title: "Locate a\nPharmacy",
                                subtitle: "Purchase Medicines",
                                background: Color(hex: "#FDCEC9")
                            )
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: Queue Box UI
    var queueBox: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            HStack(alignment: .center, spacing: 12) {
                
                // Queue Icon
                Image("queueimg")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Queue Number")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.85))
                    
                    Text("\(appState.queueNumber)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Text("See Details >")
                    .foregroundColor(.white)
                    .font(.caption)
            }
            
            ProgressView(value: 0.7)
                .tint(Color(hex: "#2D6876"))
            
            Text("Remaining 1 queue")
                .font(.caption)
                .foregroundColor(.white.opacity(0.85))
        }
        .padding()
        .background(Color(hex: "#CFE0CD"))
        .cornerRadius(20)
    }
    
}

#Preview("Home - No Appointment") {
    NavigationStack {
        HomeView()
            .environmentObject(AppState())
    }
}

#Preview("Home - With Appointment") {
    let state = AppState()
    state.hasActiveAppointment = true
    
    return NavigationStack {
        HomeView()
            .environmentObject(state)
    }
}
#Preview("MainTab") {
    MainTabView()
        .environmentObject(AppState())
}

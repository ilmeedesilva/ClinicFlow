import SwiftUI

struct PharmacyYourTurnView: View {

    @EnvironmentObject var appState: AppState
    @State private var showCompleted = false

    var body: some View {

        ZStack {

            Color(hex: "#68B2A1")
                .ignoresSafeArea()

            VStack {

                Spacer(minLength: 80)

                ZStack {

                    VStack(spacing: 22) {

                        Spacer().frame(height: 50)

                        Text("Your Turn")
                            .font(.title3)
                            .fontWeight(.semibold)

                        Spacer().frame(height: 20)

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

                        ZStack {

                            Circle()
                                .stroke(Color(hex: "#2D6876"), lineWidth: 12)
                                .frame(width: 120, height: 120)

                            Text("\(appState.queueNumber)")
                                .font(.title)
                                .fontWeight(.bold)
                        }

                        VStack(spacing: 6) {

                            Text("Please visit the pharmacy")
                                .font(.caption)

                            if let item = appState.currentItem {
                                Text("\(item.floor), \(item.room)")
                                    .font(.caption)
                            }

                            Text("Wednesday, 15 Feb")
                                .font(.caption)
                        }

                        Spacer()

                        Button {
                            appState.resetAppointment()
                            appState.selectedTab = 0
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
                        .offset(y: -50)

                        Spacer()
                    }
                }
                .padding(.horizontal, 24)

                Spacer()
            }
        }
        .onAppear {

            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                showCompleted = true
            }
        }
        .fullScreenCover(isPresented: $showCompleted) {
            PharmacyCompletedView()
                .environmentObject(appState)
        }
    }
}

#Preview {
    let state = AppState()
    state.queueNumber = 10
    state.currentItem = BookableItem(
        serviceType: .pharmacy,
        title: "Prescription",
        subtitle: "Medicine Collection",
        price: 800,
        image: "pharmacy",
        room: "Counter 03",
        floor: "First Floor"
    )

    return PharmacyYourTurnView()
        .environmentObject(state)
}

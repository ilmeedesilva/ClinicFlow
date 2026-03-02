import SwiftUI

// MARK: Data Model
struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
    let options: [String]?
    let isMapResult: Bool
}

struct ChatbotView: View {
    @Environment(\.dismiss) var dismiss
    @State private var messageText: String = ""
    @State private var currentStep = 0
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "Hi! Where are you right now?", isUser: false, options: ["Waiting Area", "Registration", "OPD Counter"], isMapResult: false)
    ]
    
    let botGray = Color(red: 0.95, green: 0.95, blue: 0.97)
    let userGreen = Color(red: 0.44, green: 0.73, blue: 0.64)
    let themeTeal = Color(red: 0.18, green: 0.41, blue: 0.45)

    var body: some View {
        VStack(spacing: 0) {
            // MARK: Header
            HStack {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3).bold().foregroundColor(.white)
                }
                Spacer()
                Text("Healthcare Assistant").font(.headline).bold().foregroundColor(.white)
                Spacer()
                Image(systemName: "chevron.left").opacity(0)
            }
            .padding()
            .background(themeTeal)

            // MARK: Chat History
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Find your destination easily")
                            .font(.subheadline).foregroundColor(.secondary)
                            .padding(.top)

                        ForEach(messages) { message in
                            if message.isMapResult {
                                routeResultCard()
                                    .id(message.id)
                            } else if message.isUser {
                                userBubble(text: message.text)
                                    .id(message.id)
                            } else {
                                botBubble(message: message)
                                    .id(message.id)
                            }
                        }
                    }
                    .padding()
                }
                .onChange(of: messages.count) { oldValue, newValue in
                    withAnimation {
                        proxy.scrollTo(messages.last?.id, anchor: .bottom)
                    }
                }
            }

            // MARK: Input Bar
            HStack(spacing: 15) {
                TextField("Type a message...", text: $messageText)
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(25)
                
                Button {
                    if !messageText.isEmpty {
                        handleChoice(messageText)
                        messageText = ""
                    }
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title3)
                        .foregroundColor(themeTeal)
                }
            }
            .padding()
            .background(userGreen.opacity(0.2))
        }
        .navigationBarHidden(true)
    }

    // MARK: Logic Handler
    func handleChoice(_ choice: String) {
        let userMsg = ChatMessage(text: choice, isUser: true, options: nil, isMapResult: false)
        messages.append(userMsg)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            if currentStep == 0 {

                messages.append(ChatMessage(
                    text: "Great! Where do you need to go?",
                    isUser: false,
                    options: ["Consultation", "X-Ray", "Pharmacy"],
                    isMapResult: false
                ))
                currentStep = 1
            } else if currentStep == 1 {

                messages.append(ChatMessage(
                    text: "I've generated the route from the \(messages[1].text) to the \(choice).",
                    isUser: false,
                    options: nil,
                    isMapResult: false
                ))
                
                messages.append(ChatMessage(text: "", isUser: false, options: nil, isMapResult: true))
                currentStep = 2
            }
        }
    }

    // MARK: Component Views
    @ViewBuilder
    func botBubble(message: ChatMessage) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 10) {
                Image("Bot")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                
                Text(message.text)
                    .padding(12)
                    .background(botGray)
                    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 15, bottomTrailingRadius: 15, topTrailingRadius: 0))
            }
            
            if let options = message.options {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(options, id: \.self) { option in
                            Button {
                                handleChoice(option)
                            } label: {
                                Text(option)
                                    .font(.system(size: 14, weight: .medium))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.white)
                                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(themeTeal, lineWidth: 1))
                                    .foregroundColor(themeTeal)
                            }
                        }
                    }
                    .padding(.leading, 40)
                }
            }
        }
    }

    func userBubble(text: String) -> some View {
        HStack {
            Spacer()
            Text(text)
                .padding(12)
                .background(userGreen)
                .foregroundColor(.white)
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 15, bottomTrailingRadius: 0, topTrailingRadius: 15))
        }
    }

    func routeResultCard() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Route: Waiting Area → Pharmacy").bold()
            
            Image("clinic_map")
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Instructions").font(.headline)
                Text("• Exit the Waiting Area via the North door.")
                Text("• Walk past the OPD Counter.")
                Text("• The Pharmacy is located next to the main exit.")
            }
            .font(.caption)
            .foregroundColor(.primary)
        }
        .padding()
        .background(botGray)
        .cornerRadius(15)
    }
}

#Preview {
    ChatbotView()
}

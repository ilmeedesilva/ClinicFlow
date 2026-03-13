import SwiftUI

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
    @State private var selectedFrom: String = ""
    @State private var selectedTo: String = ""
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "Hi! Where are you right now?", isUser: false, options: ["Waiting Area", "Registration", "OPD Counter"], isMapResult: false)
    ]
    
    let botGray = Color(red: 0.95, green: 0.95, blue: 0.97)
    let userGreen = Color(red: 0.44, green: 0.73, blue: 0.64)
    let themeTeal = Color(red: 0.18, green: 0.41, blue: 0.45)

    var body: some View {
        VStack(spacing: 0) {

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
            
            HStack(spacing: 15) {
                TextField("Type a message...", text: $messageText)
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(25)
                
                Button {
                    
                    if !messageText.isEmpty {
                        
                        let userText = messageText
                        messageText = ""
                        
                        let userMsg = ChatMessage(
                            text: userText,
                            isUser: true,
                            options: nil,
                            isMapResult: false
                        )
                        
                        messages.append(userMsg)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            
                            if let destination = detectDestination(from: userText) {
                                
                                selectedFrom = "Your Location"
                                selectedTo = destination
                                
                                messages.append(ChatMessage(
                                    text: "Here is the route to the \(destination).",
                                    isUser: false,
                                    options: nil,
                                    isMapResult: false
                                ))
                                
                                messages.append(ChatMessage(
                                    text: "",
                                    isUser: false,
                                    options: nil,
                                    isMapResult: true
                                ))
                                
                            } else {
                                
                                messages.append(ChatMessage(
                                    text: "I can help you find locations in the clinic.",
                                    isUser: false,
                                    options: helpSuggestions(),
                                    isMapResult: false
                                ))
                            }
                        }
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
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }

    func handleChoice(_ choice: String) {
        let userMsg = ChatMessage(text: choice, isUser: true, options: nil, isMapResult: false)
        messages.append(userMsg)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            
            if currentStep == 0 {
                
                selectedFrom = choice
                
                messages.append(ChatMessage(
                    text: "Great! Where do you need to go?",
                    isUser: false,
                    options: ["Consultation", "Lab", "Pharmacy"],
                    isMapResult: false
                ))
                
                currentStep = 1
                
            } else if currentStep == 1 {
                
                selectedTo = choice
                
                messages.append(ChatMessage(
                    text: "I've generated the route from the \(selectedFrom) to the \(selectedTo).",
                    isUser: false,
                    options: nil,
                    isMapResult: false
                ))
                
                messages.append(ChatMessage(
                    text: "",
                    isUser: false,
                    options: nil,
                    isMapResult: true
                ))
                
                currentStep = 2
            }
        }
    }

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
        
        let instructions = generateInstructions(from: selectedFrom, to: selectedTo)
        
        return VStack(alignment: .leading, spacing: 12) {
            
            Text("Route: \(selectedFrom) → \(selectedTo)")
                .bold()
            
            Image(mapImage(for: selectedTo))
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 5) {
                
                Text("Instructions")
                    .font(.headline)
                
                ForEach(instructions, id: \.self) { step in
                    Text("• \(step)")
                }
            }
            .font(.caption)
            .foregroundColor(.primary)
        }
        .padding()
        .background(botGray)
        .cornerRadius(15)
    }
    
    func generateInstructions(from: String, to: String) -> [String] {
        
        switch (from, to) {
            
        case ("Waiting Area", "Pharmacy"):
            return [
                "Exit the Waiting Area via the North door.",
                "Walk past the OPD Counter.",
                "The Pharmacy is located next to the main exit."
            ]
            
        case ("Waiting Area", "X-Ray"):
            return [
                "Exit the Waiting Area and turn left.",
                "Walk straight until Radiology section.",
                "The X-Ray Room is on your right."
            ]
            
        case ("Registration", "Consultation"):
            return [
                "Proceed straight from Registration desk.",
                "Take the elevator to 2nd floor.",
                "Consultation rooms are on the left corridor."
            ]
            
        case ("OPD Counter", "Pharmacy"):
            return [
                "Walk straight past the billing desk.",
                "Turn right near the elevator.",
                "Pharmacy is beside the main lobby."
            ]
            
        default:
            return [
                "Walk straight towards the main corridor.",
                "Follow the directional signs.",
                "You will reach the \(to) shortly."
            ]
        }
    }
    
    func mapImage(for destination: String) -> String {
        
        switch destination {
            
        case "Pharmacy":
            return "Pharmacy-map"
            
        case "X-Ray":
            return "Lab-map"
            
        case "Consultation":
            return "Consultation-map"
            
        default:
            return "Consultation-map"
        }
    }
    
    func detectDestination(from text: String) -> String? {
        
        let lower = text.lowercased()
        
        if lower.contains("pharmacy") {
            return "Pharmacy"
        }
        
        if lower.contains("x-ray") || lower.contains("xray") || lower.contains("lab") {
            return "X-Ray"
        }
        
        if lower.contains("consult") || lower.contains("doctor") || lower.contains("room") {
            return "Consultation"
        }
        
        return nil
    }
    
    func helpSuggestions() -> [String] {
        return [
            "Where is the pharmacy?",
            "Show me the Laboratory room",
            "Take me to consultation rooms"
        ]
    }
}

#Preview {
    ChatbotView()
}

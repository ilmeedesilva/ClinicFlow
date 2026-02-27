import SwiftUI

struct MapView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showChatbot = false
    
    let tealColor = Color(red: 0.18, green: 0.41, blue: 0.45)
    let lightGreen = Color(red: 0.44, green: 0.73, blue: 0.64)

    var body: some View {
        VStack(spacing: 0) {
            // MARK: Header
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Text("Map")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.left").opacity(0)
            }
            .padding()
            .background(tealColor)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    
                    // MARK: Map Image
                    Image("Maps")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        .padding(.top)

                    VStack(alignment: .leading, spacing: 20) {
                        Text("Find your destination easily")
                            .font(.title3)
                            .bold()
                        
                        // MARK: -Chatbot Button
                        Button {
                            showChatbot = true
                        } label: {
                            HStack {
                                // Robot Icon Circle
                                ZStack {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 50, height: 50)
                                    
                                    Image("Bot")
                                        .font(.title2)
                                        .foregroundColor(.black)
                                }
                                
                                Text("Discover Our Healthcare Chat Assistant")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 10)
                                
                                Spacer()
                                
                                ZStack {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 50, height: 50)
                                    
                                    Image(systemName: "chevron.right.2")
                                        .font(.caption)
                                        .bold()
                                        .foregroundColor(lightGreen)
                                }
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .background(lightGreen)
                            .clipShape(Capsule())
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        
    }
}

#Preview {
    MapView()
}

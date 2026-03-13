import SwiftUI

struct MapView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0

    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                    .opacity(0)
                
                Spacer()
                
                Text("Map")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.left").opacity(0)
            }
            .padding()
            .background(Color.tealColor)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    
                    Image("Consultation-Map")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(scale)
                        .offset(offset)
                        .gesture(
                            SimultaneousGesture(
                                
                                MagnificationGesture()
                                    .onChanged { value in
                                        scale = lastScale * value
                                    }
                                    .onEnded { value in
                                        lastScale = scale
                                    },
                                
                                DragGesture()
                                    .onChanged { value in
                                        offset = CGSize(
                                            width: lastOffset.width + value.translation.width,
                                            height: lastOffset.height + value.translation.height
                                        )
                                    }
                                    .onEnded { value in
                                        lastOffset = offset
                                    }
                            )
                        )
                        .onTapGesture(count: 2) {
                            withAnimation {
                                scale = 1
                                lastScale = 1
                                offset = .zero
                                lastOffset = .zero
                            }
                        }
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)

                    VStack(alignment: .leading, spacing: 20) {
                        Text("Find your destination easily")
                            .font(.title3)
                            .bold()

                        NavigationLink(destination: ChatbotView()) {
                            HStack {
                                ZStack {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 50, height: 50)
                                    
                                    Image("Bot")
                                        .resizable()
                                        .frame(width: 30, height: 30)
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
                                        .foregroundColor(Color.lightGreen)
                                }
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .background(Color.lightGreen)
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
    NavigationStack {
        MapView()
    }
}

import SwiftUI

func popupContainer<Content: View>(
    @ViewBuilder content: () -> Content
) -> some View {
    
    ZStack {
        
        Color.black.opacity(0.4)
            .ignoresSafeArea()
        
        VStack(spacing: 16) {
            content()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .padding(40)
    }
}

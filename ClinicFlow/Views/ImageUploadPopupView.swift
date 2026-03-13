import SwiftUI

struct ImageUploadPopupView: View {
    @Binding var isPresented: Bool
    let onSave: () -> Void
    
    let tealColor = Color(red: 0.18, green: 0.41, blue: 0.45)
    
    var body: some View {
        ZStack {

            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture { isPresented = false }
            

            VStack(spacing: 25) {
                Text("Upload New Profile Picture")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                

                ZStack(alignment: .bottomTrailing) {
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .foregroundColor(.green.opacity(0.7))
                    
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                        .background(Color.white.clipShape(Circle()))
                        .offset(x: 5, y: 5)
                }
                
                VStack(spacing: 5) {
                    Text("Only JPG, JPEG, PNG, or WEBP files are allowed.")
                    Text("Maximum file size: 25MB.")
                }
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                
                VStack(spacing: 15) {
                    Button {
                        isPresented = false
                    } label: {
                        Text("Cancel")
                            .font(.headline)
                            .foregroundColor(tealColor)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(tealColor, lineWidth: 2)
                            )
                    }
                    
                    Button {
                        onSave()
                        isPresented = false
                    } label: {
                        Text("Save")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(tealColor)
                            .cornerRadius(12)
                    }
                }
            }
            .padding(30)
            .background(Color.white)
            .cornerRadius(25)
            .padding(.horizontal, 30)
            .shadow(radius: 10)
        }
    }
}

#Preview {
    ImageUploadPopupView(isPresented: .constant(true)) {
        print("Save Clicked")
    }
}

import SwiftUI

struct ButtonWithPressEffect: View {
    @Binding var icon: IconItem

    var body: some View {
        VStack(spacing: 10) { // Space between icon and text
            ZStack {
                Circle()
                    .fill(Color(hue: 0.585, saturation: 0.412, brightness: 1.0))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 5)
                    )
                Image(systemName: icon.systemName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundColor (.white)
            }
            .scaleEffect(icon.isPressed ? 1.4 : 1.0)
            .opacity(icon.isPressed ? 0.6 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: icon.isPressed)
            .gesture(
                LongPressGesture(minimumDuration: 0.1)
                    .onChanged { _ in
                        withAnimation(.easeInOut(duration: 0.1)) {
                            icon.isPressed = true
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.easeInOut(duration: 0.1)) {
                            icon.isPressed = false
                        }
                        // Add any additional actions here
                    }
            )
            Text(icon.name)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.411))
                .multilineTextAlignment(.center)
                .padding(0.0)
        }
        .frame(width: 43)
        .padding()
    }
}

struct ButtonWithPressEffect_Previews: PreviewProvider {
    @State static var icon = IconItem(name: "Fruits & Veg", systemName: "leaf.fill")
    static var previews: some View {
        ButtonWithPressEffect(icon: $icon)
    }
}

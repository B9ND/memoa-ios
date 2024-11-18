import SwiftUI
struct AuthBackground: View {
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.darkmaincolor, Color.maincolor]),
                       startPoint: .top, endPoint: .bottom)
        .overlay (
            Image(icon: .cloud)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 1075)
                .offset(y:300)
        )
    }
}

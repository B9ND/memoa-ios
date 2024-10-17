import SwiftUI
struct AuthText: View {
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .font(.bold(30))
            .padding(.top, 130)
            .padding(.bottom, 46)
    }
}

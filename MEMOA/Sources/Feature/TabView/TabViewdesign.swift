import SwiftUI

struct TabViewdesign: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(.white)
                .frame(width: 100, height: 120)
                .shadow(radius: 1)
                .padding(.bottom, 25)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(maxWidth: .infinity, maxHeight: 95)
                .shadow(radius: 1)
            
            RoundedRectangle(cornerRadius: 100)
                .fill(.white)
                .frame(width: 120, height: 90)
                .padding(.bottom, 15)
        }
    }
}

#Preview {
    TabViewdesign()
}

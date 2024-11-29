import SwiftUI
import Kingfisher
import Zoomable

struct ImageDetailView: View {
    let imageUrl: String

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                KFImage(URL(string: imageUrl))
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .cornerRadius(8, corners: .allCorners)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .zoomable()
            }
        }
        .enableNavigationSwipe()
        .addBackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .white)
    }
}

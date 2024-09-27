import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            SelectitemView()
            Divider()
            ScrollView {
                LazyVStack {
                    UploadComponentView(board: BoardModel(nickname: "유을", time: "시발몇시야", image: [Imagelist(image: "example")], title: "tlqkf", tag: "tlqkf", email: "eunchan2815@gmail.com")) {
                        print("hello")
                    }
                }
                Spacer()
            }
            .refreshable {
                
            }
        }
    }
}

#Preview {
    HomeView()
}

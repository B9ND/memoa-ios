import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                SelectitemView()
                Divider()
                ScrollView {
                    LazyVStack {
                        UploadComponentView(board: BoardModel(nickname: "유을", time: "2024-09-29", image: [Imagelist(image: "example")], title: "과학수학필기 공유합니다", tag: "공부하기싫다", email: "eunchan2815@gmail.com")) {
                            print("정보주기")
                        }
                    }
                    Spacer()
                }
                .refreshable {
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

import SwiftUI

//팔로워 수
struct Myfollower: View {
    var board: followModel
    @State private var toFollower = false
    @State private var toFollowing = false
    @State private var isNavigation = false
    let text: String

    var body: some View {
        Button {
            isNavigation = true
            toFollower = true
        } label: {
            VStack {
                Text(board.number)
                    .font(.medium(16))
                    .foregroundStyle(.black)
                Text(text)
                    .font(.regular(10))
                    .foregroundStyle(.black)
            }
        }
        .navigationDestination(isPresented: $isNavigation) {
            FollowView(toFollower: $toFollower, toFollowing: $toFollowing, followBoard: board)
        }
    }
}

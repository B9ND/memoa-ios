import SwiftUI

//팔로워 수
struct Myfollower: View {
    @State private var toFollower = false
    @State private var toFollowing = false
    @State private var isNavigation = false
    var board: followModel
    let text: String

    var body: some View {
        Button {
            isNavigation = true
            toFollower = true
            toFollowing = false
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

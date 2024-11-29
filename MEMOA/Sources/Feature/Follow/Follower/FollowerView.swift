//
//  followerView.swift
//  MEMOA
//
//  Created by dgsw30 on 10/18/24.
//

import SwiftUI

struct FollowerView: View {
    @StateObject var followerVM = FollowerViewModel()
    let id : String
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(followerVM.followers, id: \.email) { follower in
                    FollowerComponent(
                        follower: follower,
                        action: {
                            followerVM.follow(nickname: follower.nickname)
                        }
                    )
                }
            }
        }
        .onAppear {
            followerVM.getFollower(nickname: id)
        }
    }
}

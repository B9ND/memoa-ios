//
//  followingView.swift
//  MEMOA
//
//  Created by dgsw30 on 10/18/24.
//

import SwiftUI

struct FollowingView: View {
    @StateObject var followingVM = FollowingViewModel()
    let id : String
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(followingVM.followings, id: \.email) { follower in
                    FollowingComponent(
                        following: follower,
                        action: {
                            followingVM.follow(nickname: follower.nickname)
                        }
                    )
                }
            }
        }
        .onAppear {
            followingVM.getFollowing(nickname: id)
        }
    }
}

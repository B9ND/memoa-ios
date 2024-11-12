//
//  followingView.swift
//  MEMOA
//
//  Created by dgsw30 on 10/18/24.
//

import SwiftUI

struct FollowingView: View {
    @StateObject var followingVM = FollowingViewModel()
    //TODO: 이거수정
    let id : String
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(followingVM.followings, id: \.email) { follower in
                    FollowingComponent(following: follower)
                }
            }
        }
        .onAppear {
            followingVM.getFollowing(nickname: id)
        }
    }
}

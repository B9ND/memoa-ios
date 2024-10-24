//
//  Following.swift
//  MEMOA
//
//  Created by dgsw30 on 10/17/24.
//

import SwiftUI

//MARK: 팔로워 팔로우 목록
struct FollowView: View {
    @Binding var toFollower: Bool
    @Binding var toFollowing: Bool
    var followBoard: followModel
    var body: some View {
        VStack {
            HStack {
                Button {
                    toFollower = true
                    toFollowing = false
                } label: {
                    VStack {
                        Text("팔로워")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                        Rectangle()
                            .fill(toFollower ? Color.black : Color.clear)
                            .frame(width: 63, height: 1)
                    }
                }
                
                Spacer()
                
                Button {
                    toFollower = false
                    toFollowing = true
                } label: {
                    VStack {
                        Text("팔로잉")
                            .foregroundColor(.black)
                            .font(.system(size: 14))
                        Rectangle()
                            .fill(toFollowing ? Color.black : Color.clear)
                            .frame(width: 63, height: 1)
                    }
                }
            }
            .padding(.horizontal, 90)
            
            if toFollower {
                FollowerView()
            } else if toFollowing {
                FollowingView()
            }
        }
        Spacer()
        BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .black)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text(followBoard.nickname)
                        .font(.medium(16))
                        .padding(.trailing, 165)
                }
            }
    }
}

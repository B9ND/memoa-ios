//
//  FollwerComponent.swift
//  MEMOA
//
//  Created by dgsw30 on 11/2/24.
//

import SwiftUI

struct FollowerComponent: View {
    let follower : FollowerModel
    @State private var toProfile = false
    var body: some View {
        HStack {
            Button  {
                toProfile = true
            } label: {
                let url = URL(string: follower.profileImage)
                AsyncImage(url: url) { image in
                    image
                        .image?.resizable()
                        .cornerRadius(30, corners: .allCorners)
                        .frame(width: 55, height: 55)
                        .padding(.trailing, 10)
                }
            }
            
            Text(follower.nickname)
                .font(.medium(16))
            Spacer()
            FollowButton {
                
            }
        }
        .navigationDestination(isPresented: $toProfile, destination: {
            ProfileView(username: .constant(follower.nickname))
        })
        .padding(.horizontal, 13)
        .padding()
    }
}

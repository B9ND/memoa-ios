//
//  FollwerComponent.swift
//  MEMOA
//
//  Created by dgsw30 on 11/2/24.
//

import SwiftUI

struct FollowerComponent: View {
    let follower : FollowerModel
    var body: some View {
        HStack {
            
            let url = URL(string: follower.profileImage)
            AsyncImage(url: url) { image in
                image
                    .image?.resizable()
                    .cornerRadius(30, corners: [.topLeft, .bottomLeft, .topRight, .bottomRight])
                    .frame(width: 55, height: 55)
                    .padding(.trailing, 10)
            }
            
            Text(follower.nickname)
                .font(.medium(16))
            Spacer()
            FollowButton {
                
            }
        }
        .padding(.horizontal, 13)
        .padding()
    }
}

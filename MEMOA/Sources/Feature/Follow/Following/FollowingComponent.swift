//
//  FollowingComponent.swift
//  MEMOA
//
//  Created by dgsw30 on 11/3/24.
//

import SwiftUI

struct FollowingComponent: View {
    let following : FollowingModel
    var body: some View {
        HStack {
            let url = URL(string: following.profileImage)
            AsyncImage(url: url) { image in
                image
                    .image?.resizable()
                    .cornerRadius(30, corners: [.topLeft, .bottomLeft, .topRight, .bottomRight])
                    .frame(width: 55, height: 55)
                    .padding(.trailing, 10)
            }
            Text(following.nickname)
                .font(.medium(16))
            Spacer()
            FollowButton {
                
            }
        }
        .padding(.horizontal, 13)
        .padding()
    }
}

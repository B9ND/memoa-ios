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
            Image(icon: .largeprofile)
                .padding(.trailing, 10)
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

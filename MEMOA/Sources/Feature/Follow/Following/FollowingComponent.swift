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
            Image(icon: .largeprofile)
                .padding(.trailing, 10)
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

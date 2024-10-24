//
//  followingButton.swift
//  MEMOA
//
//  Created by dgsw30 on 10/17/24.
//

import SwiftUI
//MARK: 팔로우버튼
struct FollowButton: View {
    @State private var follow = false
    let action: () -> Void
    var body: some View {
        Button {
            follow.toggle()
        } label: {
            Text(follow ? "언팔로우" : "팔로우")
                .font(.regular(10))
                .frame(width: 87, height: 21)
                .background(follow ?  Color.white : Color.maincolor)
                .cornerRadius(8)
                .foregroundStyle(follow ? .black : .white)
                .overlay {
                    if follow {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.graycolor, lineWidth: 1)
                    }
                }
        }
    }
}

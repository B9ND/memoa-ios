//
//  followerView.swift
//  MEMOA
//
//  Created by dgsw30 on 10/18/24.
//

import SwiftUI

struct FollowerView: View {
    var body: some View {
        HStack {
            Image(icon: .largeprofile)
                .padding(.trailing, 10)
            Text("김은찬")
                .font(.medium(16))
            Spacer()
            FollowButton {
                print("클릭")
            }
        }
        .padding(.horizontal, 13)
        .padding()
    }
}

#Preview {
    FollowerView()
}

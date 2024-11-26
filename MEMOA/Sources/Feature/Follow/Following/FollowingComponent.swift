//
//  FollowingComponent.swift
//  MEMOA
//
//  Created by dgsw30 on 11/3/24.
//

import SwiftUI

struct FollowingComponent: View {
    @State private var toProfile = false
    let following : FollowingModel
    var body: some View {
        HStack {
            Button  {
                toProfile = true
            } label: {
                let url = URL(string: following.profileImage)
                AsyncImage(url: url) { image in
                    image
                        .image?.resizable()
                        .cornerRadius(30, corners: .allCorners)
                        .frame(width: 55, height: 55)
                        .padding(.trailing, 10)
                }
            }
            Text(following.nickname)
                .font(.medium(16))
            Spacer()
            FollowButton {
                
            }
        }
        .navigationDestination(isPresented: $toProfile, destination: {
            ProfileView(username: .constant(following.nickname))
        })
        .padding(.horizontal, 13)
        .padding()
    }
}

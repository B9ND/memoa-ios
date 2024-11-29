//
//  FollowingComponent.swift
//  MEMOA
//
//  Created by dgsw30 on 11/3/24.
//

import SwiftUI

struct FollowingComponent: View {
    @StateObject private var myInformation = MyProfileViewModel()
    @State var following : FollowingModel
    @State private var toProfile = false
    let action: () -> Void
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
            VStack {
                if let profile = myInformation.profile {
                    if following.email == profile.email {
                        Text("MY")
                            .font(.regular(10))
                            .frame(width: 87, height: 21)
                            .background(Color.white)
                            .cornerRadius(8)
                            .foregroundStyle(.black)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.graycolor, lineWidth: 1)
                            }
                    } else {
                        FollowButton(follow: following.isFollowed) {
                            action()
                            following.isFollowed.toggle()
                        }
                    }
                }
            }
        }
        .navigationDestination(isPresented: $toProfile, destination: {
            ProfileView(username: .constant(following.nickname))
        })
        .onAppear {
            myInformation.fetchMy()
        }
        .padding(.horizontal, 13)
        .padding()
    }
}

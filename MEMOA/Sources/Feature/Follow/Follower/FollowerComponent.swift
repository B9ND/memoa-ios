//
//  FollwerComponent.swift
//  MEMOA
//
//  Created by dgsw30 on 11/2/24.
//

import SwiftUI

struct FollowerComponent: View {
    @StateObject private var myInformation = MyProfileViewModel()
    @State var follower: FollowerModel
    @State private var toProfile = false
    let action: () -> Void
    
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
            VStack {
                if let profile = myInformation.profile {
                    if follower.email == profile.email {
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
                        FollowButton(follow: follower.isFollowed) {
                            action()
                            follower.isFollowed.toggle()
                        }
                    }
                }
            }
        }
        .navigationDestination(isPresented: $toProfile, destination: {
            ProfileView(username: .constant(follower.nickname))
        })
        .onAppear {
            myInformation.fetchMy()
        }
        .padding(.horizontal, 13)
        .padding()
    }
}

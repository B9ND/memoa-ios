//
//  BookmarkComponentView.swift
//  MEMOA
//
//  Created by dgsw30 on 11/15/24.
//

import SwiftUI

//MARK: 게시글
struct BookmarkComponentView: View {
    @State private var toDetail = false
    @State private var showingAlert = false
    @State private var toProfile = false
    let post: BookmarkModel
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
            toDetail = true
        } label: {
                VStack {
                    HStack {
                        Button {
                            toProfile = true
                        } label: {
                            if let url = URL(string: post.profileImage) {
                                AsyncImage(url: url) { image in
                                    image
                                        .image?.resizable()
                                        .cornerRadius(30)
                                        .frame(width: 37, height: 37)
                                }
                            }
                        }
                        .padding(.leading, 24)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text(post.nickname)
                                    .foregroundStyle(.black)
                                    .font(.medium(14))
                                Circle()
                                    .frame(width: 5, height: 4)
                                    .tint(Color(uiColor: .systemGray3))
                                Text(post.createdAt)
                                    .font(.medium(12))
                                    .foregroundColor(.timecolor)
                            }
                            .padding(.vertical, 2)
                            
                            Text(post.title)
                                .foregroundColor(.timecolor)
                                .font(.light(13))
                        }
                        Spacer()
                    }
                    
//                    VStack {
//                        ScrollView(.horizontal) {
//                            HStack(spacing: 3) {
//                                ForEach(post.getImageUrl, id: \.self) { url in
//                                    AsyncImage(url: url) { image in
//                                        image
//                                            .image?.resizable()
//                                            .cornerRadius(8, corners: [.allCorners])
//                                            .aspectRatio(contentMode: .fit)
//                                            .frame(width: 220,height: 240)
//                                            .padding(.leading, 10)
//                                    }
//                                }
//                            }
//                            .padding(.horizontal, 70)
//                        }
//                        .scrollIndicators(.hidden)
//                    }
                    
                    VStack {
//                        ScrollView(.horizontal) {
//                            HStack {
//                                ForEach(post.tags, id: \.self) { tag in
//                                    Text("#\(tag)")
//                                        .font(.regular(12))
//                                        .foregroundStyle(Color.timecolor)
//                                }
//                                Spacer()
//                            }
//                        }
//                        .scrollIndicators(.hidden)
                        HStack {
                            ChatButton {
                                // TODO: Handle
                            }
                            BookmarkButton(id: .constant(post.postId))
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 70)
                    Divider()
                    Spacer()
                }
        }
    }
}

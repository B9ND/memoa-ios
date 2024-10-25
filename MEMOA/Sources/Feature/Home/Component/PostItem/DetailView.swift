//
//  DetailView.swift
//  MEMOA
//
//  Created by dgsw30 on 9/10/24.
//

import SwiftUI

//MARK: 게시물 자세히
struct DetailView: View {
    @State private var showingAlert = false
    @State private var toProfile = false
    @Environment(\.dismiss) private var dismiss
    var getPost: GetDetailPost
    
    var body: some View {
        VStack {
            HStack {
                ProfileButton(action: {
                    toProfile = true
                }, image: "homeprofil")
                    .padding(.leading, 4)
                VStack(alignment: .leading) {
                    HStack {
                        Text(getPost.author)
                            .foregroundStyle(.black)
                            .font(.medium(16))
                        Circle()
                            .frame(width: 5,height: 4)
                            .tint(Color.init(uiColor: .systemGray3))
                        Text(getPost.createdAt)
                            .font(.medium(14))
                            .foregroundColor(.timecolor)
                    }
                    .padding(.vertical, 1)
                    
                    Text(getPost.title)
                        .foregroundColor(.timecolor)
                        .font(.light(16))
                }
                Spacer()
            }
            .padding()
            Divider()
            ScrollView {
                VStack {
                    Text(getPost.content)
                        .font(.light(18))
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 3) {
                            ForEach(getPost.getImageUrl, id: \.self) { url in
                                AsyncImage(url: url) { image in
                                    image
                                        .image?.resizable()
                                        .frame(width: 220, height: 240)
                                        .cornerRadius(8, corners: .topLeft)
                                        .cornerRadius(8, corners: .bottomLeft)
                                        .cornerRadius(8, corners: .topRight)
                                        .cornerRadius(8, corners: .bottomRight)
                                        .padding(.leading, 10)
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .padding(.bottom, 30)
                    VStack {
                        HStack {
                            ForEach(getPost.tags, id: \.self) { tag in
                                Text("#\(tag)")
                                    .font(.regular(12))
                                    .foregroundStyle(Color.timecolor)
                            }
                            Spacer()
                        }
                        HStack {
                            ChatButton()
                            BookmarkButton()
                            Spacer()
                        }
                    }
                    .padding(.leading, 14)
                }
            }
            .padding()
            Spacer()
            BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .black)
        }

        //프로필은 다른 보드로 하면 좋을듯?
    }
}

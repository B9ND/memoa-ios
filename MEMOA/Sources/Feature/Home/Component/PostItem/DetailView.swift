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
                ProfileButton(type: .home) {
                    toProfile = true
                }
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
                    ForEach(getPost.content.components(separatedBy: "\n"), id: \.self) { line in
                        if line.hasPrefix("✔★") {
                            let imageUrl = line
                                .replacingOccurrences(of: "✔★", with: "")
                                .replacingOccurrences(of: "✔", with: "")
                            if let url = URL(string: imageUrl) {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .cornerRadius(8)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 220, height: 240)
                                        .padding(.leading, 10)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        } else {
                            Text(line)
                                .font(.light(18))
                                .padding(.horizontal, 36)
                        }
                    }
                    
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
                            ChatButton {
                                // TODO: Handle
                            }
                            BookmarkButton()
                            Spacer()
                        }
                    }
                }
                .padding(.trailing, 150)
            }
            .padding(.leading, 15)
            Spacer()
            BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .black)
        }
        .navigationDestination(isPresented: $toProfile) {
            ProfileView(information: getPost)
        }
    }
}

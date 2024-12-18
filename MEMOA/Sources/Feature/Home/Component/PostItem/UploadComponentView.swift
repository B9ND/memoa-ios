import SwiftUI
import Kingfisher

//MARK: 게시글
struct UploadComponentView: View {
    @State private var toDetail = false
    @State private var showingAlert = false
    @State private var toProfile = false
    let post: GetPostModel
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
                        if let url = URL(string: post.authorProfileImage) {
                            KFImage(url)
                                .placeholder { _ in
                                    Circle()
                                        .fill(Color.black)
                                        .cornerRadius(30)
                                        .frame(width: 37, height: 37)
                                        .shimmer()
                                }
                                .resizable()
                                .cornerRadius(30)
                                .frame(width: 37, height: 37)
                        }
                    }
                    .padding(.leading, 24)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(post.author)
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
                
                VStack {
                    ScrollView(.horizontal) {
                        HStack(spacing: 3) {
                            ForEach(post.imageUrls, id: \.self) { url in
                                KFImage(url)
                                    .placeholder { _ in
                                        Rectangle()
                                            .fill(Color.black)
                                            .frame(width: 220,height: 240)
                                            .cornerRadius(8, corners: .allCorners)
                                            .shimmer()
                                    }
                                    .resizable()
                                    .cornerRadius(8, corners: .allCorners)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 220,height: 240)
                                    .padding(.leading, 10)
                            }
                        }
                        .padding(.horizontal, 70)
                    }
                    .scrollIndicators(.hidden)
                }
                
                VStack {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(post.tags, id: \.self) { tag in
                                Text("#\(tag)")
                                    .font(.regular(12))
                                    .foregroundStyle(Color.timecolor)
                            }
                            Spacer()
                        }
                    }
                    .scrollIndicators(.hidden)
                    HStack {
                        ChatButton()
                        BookmarkButton(isBookmark: .constant(post.isBookmarked), id: .constant(post.id))
                        Spacer()
                    }
                }
                .padding(.leading, 70)
                Divider()
                Spacer()
            }
        }
        .navigationDestination(isPresented: $toProfile) {
            ProfileView(username: .constant(post.author))
        }
    }
}

import SwiftUI

struct UploadComponentView: View {
    @State private var toDetail = false
    @State private var showingAlert = false
    @State private var toProfile = false
    var post: GetPostModel
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
            toDetail = true
        } label: {
            VStack {
                HStack {
                    ProfileButton(type: .home) {
                        toProfile = true
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
                            ForEach(post.getImageUrl, id: \.self) { url in
                                AsyncImage(url: url) { image in
                                    image
                                        .image?.resizable()
                                        .cornerRadius(8, corners: .topLeft)
                                        .cornerRadius(8, corners: .bottomLeft)
                                        .cornerRadius(8, corners: .topRight)
                                        .cornerRadius(8, corners: .bottomRight)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 220,height: 240)
                                        .padding(.leading, 10)
                                }
                            }
                        }
                        .padding(.horizontal, 70)
                    }
                    .scrollIndicators(.hidden)
                }
                
                VStack {
                    HStack {
                        ForEach(post.tags, id: \.self) { tag in
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
                .padding(.horizontal, 70)
                Divider()
                Spacer()
            }
        }
    }
}

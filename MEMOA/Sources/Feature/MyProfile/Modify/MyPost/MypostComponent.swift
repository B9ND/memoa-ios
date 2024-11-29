import SwiftUI
import Kingfisher

struct MypostComponent: View {
    @State private var toDetail = false
    @State private var showingAlert = false
    @State private var toProfile = false
    let post: MyPostModel?
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
            toDetail = true
        } label: {
            if let myPost = post {
                VStack {
                    HStack {
                        Button {
                            toProfile = true
                        } label: {
                            if let url = URL(string: myPost.authorProfileImage) {
                                KFImage(url)
                                    .placeholder { _ in
                                        Circle()
                                            .fill(Color.black)
                                            .scaledToFit()
                                            .cornerRadius(30)
                                            .frame(width: 37, height: 37)
                                    }
                                    .resizable()
                                    .cornerRadius(30)
                                    .frame(width: 37, height: 37)
                            }
                        }
                        .padding(.leading, 24)
                        VStack(alignment: .leading) {
                            HStack {
                                Text(myPost.author)
                                    .foregroundStyle(.black)
                                    .font(.medium(14))
                                Circle()
                                    .frame(width: 5, height: 4)
                                    .tint(Color(uiColor: .systemGray3))
                                Text(myPost.createdAt)
                                    .font(.medium(12))
                                    .foregroundColor(.timecolor)
                            }
                            .padding(.vertical, 2)
                            
                            Text(myPost.title)
                                .foregroundColor(.timecolor)
                                .font(.light(13))
                        }
                        Spacer()
                    }
                    
                    VStack {
                        ScrollView(.horizontal) {
                            HStack(spacing: 3) {
                                ForEach(myPost.imageUrls, id: \.self) { url in
                                    KFImage(url)
                                        .placeholder { _ in
                                            Rectangle()
                                                .fill(Color.black)
                                                .cornerRadius(8, corners: .allCorners)
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 220,height: 240)
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
                                ForEach(myPost.tags, id: \.self) { tag in
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
                            BookmarkButton(isBookmark: .constant(myPost.isBookmarked), id: .constant(myPost.id))
                            Spacer()
                        }
                    }
                    .padding(.leading, 70)
                    Divider()
                    Spacer()
                }
            }
        }
    }
}


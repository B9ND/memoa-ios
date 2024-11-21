import SwiftUI

struct SearchComponentView: View {
    @State private var toDetail = false
    @State private var showingAlert = false
    @State private var toProfile = false
    var post: ServerResponse
    var action: () -> Void

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // 원하는 형식으로 설정
        return formatter
    }

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
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .cornerRadius(30)
                                        .frame(width: 37, height: 37)
                                case .failure:
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .frame(width: 37, height: 37)
                                        .foregroundColor(.gray)
                                default:
                                    ProgressView()
                                        .frame(width: 37, height: 37)
                                }
                            }
                        }
                    }

                    VStack(alignment: .leading) {
                        HStack {
                            Text(post.author)
                                .foregroundStyle(.black)
                                .font(.medium(14))
                            Circle()
                                .frame(width: 5, height: 4)
                                .tint(Color(uiColor: .systemGray3))
                            Text(dateFormatter.string(from: post.createdAt))
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
                            ForEach(post.images, id: \.self) { imageUrl in
                                if let url = URL(string: imageUrl) {
                                    AsyncImage(url: url) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .cornerRadius(8)
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 220, height: 240)
                                                .padding(.leading, 10)
                                        case .failure:
                                            Rectangle()
                                                .fill(Color.gray.opacity(0.3))
                                                .frame(width: 220, height: 240)
                                                .cornerRadius(8)
                                        default:
                                            ProgressView()
                                                .frame(width: 220, height: 240)
                                        }
                                    }
                                } else {
                                    // URL 변환 실패 시 대체 UI
                                    Rectangle()
                                        .fill(Color.red.opacity(0.3))
                                        .frame(width: 220, height: 240)
                                        .cornerRadius(8)
                                        .overlay(
                                            Text("Invalid URL")
                                                .font(.caption)
                                                .foregroundColor(.white)
                                        )
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
                        ChatButton {
                            // TODO: Handle
                        }
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

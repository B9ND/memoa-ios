import Foundation

struct MyPostModel: Decodable {
    let id: Int
    let title, content, author, authorProfileImage: String
    let tags: [String]
    let createdAt: String
    let images: [String]
    var getImageUrl: [URL] {
        images.compactMap { URL(string: $0) }
    }
    let isBookmarked: Bool
}

import Foundation

struct MyPostModel: Decodable, HasImage {
    let id: Int
    let title, content, author, authorProfileImage: String
    let tags: [String]
    let createdAt: String
    let images: [String]
    let isBookmarked: Bool
}

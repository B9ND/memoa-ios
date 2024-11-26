import SwiftUI

struct BookmarkModel: Codable, HasImage {
    let nickname: String
    let postId: Int
    let title: String
    let profileImage: String
    let createdAt: String
    let images: [String]
    let tags: [String]
}

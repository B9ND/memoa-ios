import SwiftUI

struct BookmarkModel: Codable {
    let nickname: String
    let postId: Int
    let title: String
    let profileImage: String
    let createdAt: String
    let images: [String]
    let tags: [String]
    var getImageUrl: [URL] {
        images.compactMap { URL(string: $0) }
    }
}

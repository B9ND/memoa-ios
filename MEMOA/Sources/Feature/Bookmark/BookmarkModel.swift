import SwiftUI

struct BookmarkModel: Codable {
    let nickname: String
    let postId: Int
    let title: String
    let profileImage: String
    let createdAt: String
//    var getImageUrl: [URL] {
//        images.compactMap { URL(string: $0) }
//    }
}

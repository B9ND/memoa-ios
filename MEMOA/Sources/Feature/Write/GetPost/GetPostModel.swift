import Foundation

//MARK: 게시글(홈화면)
struct GetPostModel: Codable, HasImage {
    let id: Int
    let title: String
    let author: String
    let authorProfileImage: String
    let tags: [String]
    let createdAt: String
    let images: [String]
    let isBookmarked: Bool
}

protocol HasImage {
    var images: [String] { get }
}

extension HasImage {
    var imageUrls: [URL] {
        images.compactMap { URL(string: $0) }
    }
}

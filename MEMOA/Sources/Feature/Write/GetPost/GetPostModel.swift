import Foundation

//MARK: 이름수정
struct GetPostModel: Codable {
    let id: Int
    let title: String
    let content: String
    let author: String
    let tags: [String]
    let createdAt: String
    let images: [String]
    var getImageUrl: [URL] {
        images.compactMap { URL(string: $0) }
    }
}

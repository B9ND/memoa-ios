import Foundation

//MARK: 게시글(홈화면)
struct GetPostModel: Codable {
    let id: Int
    let title: String
//    let content: String
    //MARK: home에서 content필요없을듯?
    let author: String
    let authorProfileImage: String
    let tags: [String]
    let createdAt: String
    let images: [String]
    let isBookmarked: Bool
    var getImageUrl: [URL] {
        images.compactMap { URL(string: $0) }
    }
}

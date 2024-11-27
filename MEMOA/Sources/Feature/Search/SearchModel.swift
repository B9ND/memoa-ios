import Foundation

struct searchSelectSchoolModel {
    var grade: [gradeitem]
}

struct searchGradeItem: Encodable {
    var grade: Int
    
    init(grade: Int) {
        self.grade = grade
    }
}

//서버 응답 모델
struct ServerResponse: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let content: String
    let author: String
    let authorProfileImage: String
    let tags: [String]
    let createdAt: String
    let images: [String]
    let isBookmarked: Bool
    
    // Computed property to convert image strings to URLs
    var imageUrls: [URL] {
        images.compactMap { URL(string: $0) }
    }
    
    //검색 모델
    struct SearchRequest: Encodable {
        let search: String
        let tags: [String]
        let page: Int32
        let size: Int32
        
        enum CodingKeys: String, CodingKey {
            case search, tags, page, size
        }
    }
}
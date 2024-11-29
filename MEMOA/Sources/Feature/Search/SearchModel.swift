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

struct ServerResponse: Codable, Identifiable, Hashable, HasImage {
    let id: Int
    let title: String
    let content: String
    let author: String
    let authorProfileImage: String
    let tags: [String]
    let createdAt: String
    let images: [String]
    let isBookmarked: Bool
    
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

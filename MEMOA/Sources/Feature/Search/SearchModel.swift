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

/// 게시물 서버 응답 모델
struct ServerResponse: Codable, Identifiable, Hashable {
    var id: Int
    var title: String
    var content: String
    var author: String
    var authorProfileImage: String
    var tags: [String]
    var createdAt: Date
    var images: [String]
}

/// 검색 모델 (검색 조건 전달용)
struct SearchModel: Codable {
    var tags: [String]
    var search: String
    var page: Int32
    var size: Int32
}

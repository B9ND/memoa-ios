struct TokenResponse: Decodable {
    let accessToken: String
    let refreshToken: String
    
    // JSON 키와 프로퍼티 간의 매핑을 위한 CodingKeys
    enum CodingKeys: String, CodingKey {
        case accessToken = "access"
        case refreshToken = "refresh"
    }
}

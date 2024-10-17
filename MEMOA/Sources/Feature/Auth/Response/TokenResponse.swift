struct TokenData: Codable {
    let accessToken: String
    let refreshToken: String
}

struct BaseResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String
    let data: T
}

import Foundation

//MARK: patch할때 모델
struct ModifyModel: Encodable, Decodable {
    var nickname: String
    var description: String
    var profileImage: String
    var department: Int
    var password: String
    var pastPassword: String
}

import Foundation

struct UploadMyimage: Hashable {
    var imageurl: String
}

struct MyProfilModel {
    var name: String = "박재민"
    var email: String = "pjmin0923@gmail.com"
    var image: [UploadMyimage]
}

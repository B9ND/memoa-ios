import Foundation

struct Uploadimage: Hashable {
    var imageurl: String
    
    init(imageurl: String) {
        self.imageurl = imageurl
    }
}

struct ProfileModel {
    var name: String = "김은찬"
    var email: String = "kimeunchan2815@gmail.com"
    var image: [Uploadimage]
}

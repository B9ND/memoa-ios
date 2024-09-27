import Foundation

struct Uploadimage: Hashable {
    var imageurl: String
    
    init(imageurl: String) {
        self.imageurl = imageurl
    }
}

struct ProfileModel {
    var image: [Uploadimage]
}

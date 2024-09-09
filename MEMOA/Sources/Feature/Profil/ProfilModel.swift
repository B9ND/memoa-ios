import SwiftUI

struct Uploadimage: Hashable {
    var imageurl: String
}

struct ProfilModel {
    var name: String = "박재민"
    var email: String = "pjmin0923@gmail.com"
    var image: [Uploadimage]
}



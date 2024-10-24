import Foundation

struct BoardModel {
    var nickname: String
    var time: String
    var image: [Imagelist]
    var title: String
    var tag: String
    var email: String
}

struct Imagelist: Identifiable {
    var id = UUID()
    var image: String
}

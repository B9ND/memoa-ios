import SwiftUI
import PhotosUI

struct WriteModel {
    var title: String
    var content: [ContentItem]
    var tags: [String]
    var images: [ImageItem]
    var isReleased: Bool
}

struct ContentItem {
    var text: NSMutableAttributedString
}

struct ImageItem {
    var images: [String]
}

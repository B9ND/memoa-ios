import SwiftUI
import PhotosUI

struct WriteModel {
    let title: String
    let content: [ContentItem]
    let tags: [String]
    let images: [ImageItem]
    let isReleased: Bool
    let postContent: [String]
}

struct ContentItem {
    var text: NSMutableAttributedString
}

struct ImageItem {
    var images: [String]
}

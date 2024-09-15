import SwiftUI
import PhotosUI

struct TagData: Encodable {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    public func getName() -> String {
        return name
    }
    
    public mutating func setName(name: String) {
        self.name = name
    }
}

struct WriteModel {
    var title: String = "" // 타이틀
    var content: [ContentItem] = [] // 새글 넣는 리스트
    var tags: [TagData] // 태그
    var isReleased: Bool = true // 공개 비공개
    
    
    var postBody: [String: Any] {
        [
            "title": title,
            "content": content, 
            "tags": tags.map { $0.name }
            
        ]
    }
}

struct ContentItem {
    var selectedItem: PhotosPickerItem?
    var text: NSMutableAttributedString
}


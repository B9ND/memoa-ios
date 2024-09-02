import SwiftUI

class WriteViewModel: ObservableObject {
    @Published var request: WriteModel = .init(tags: [
        TagData(name: "국어"),
        TagData(name: "수학"),
        TagData(name: "사회"),
        TagData(name: "과학"),
        TagData(name: "영어"),
        TagData(name: "기타")
    ])
    
    @Published var Tagselection = [] // 선택된 태그 이걸 저기 모델에 있는 tags리스트에 넣어야함

    @Published var contentItem: ContentItem = ContentItem(selectedItem: nil, text: NSMutableAttributedString())
}

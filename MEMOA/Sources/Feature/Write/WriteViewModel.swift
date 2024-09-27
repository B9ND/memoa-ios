import Foundation

class WriteViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var content: [ContentItem] = []
    @Published var tags: [TagData] = [
        TagData(name: "국어"),
        TagData(name: "수학"),
        TagData(name: "과학"),
        TagData(name: "사회"),
        TagData(name: "영어"),
        TagData(name: "기타")
    ]
    @Published var isReleased: Bool = true
    @Published var createdAt: Int = 2024-09-19
    
    @Published var Tagselection = []

    @Published var contentItem: ContentItem = ContentItem(selectedItem: nil, text: NSMutableAttributedString())
    
    //    TODO:이미지 url
    //    func a() {
    //        AF.upload(multipartFormData: { form in
    //            form.append(<#T##fileURL: URL##URL#>, withName: <#T##String#>)
    //        }, with: <#T##any URLRequestConvertible#>)
    //    }
}


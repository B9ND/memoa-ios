import Foundation
import _PhotosUI_SwiftUI
import Alamofire

struct WritePostRequest: Encodable {
    let title: String
    let content: String
    let tags: [String]
    let images: [String]
    let isReleased: Bool
}

class WriteViewModel: ObservableObject {
    // MARK: POST
    @Published var title: String = "" // 타이틀
    @Published var content = ContentItem(text: NSMutableAttributedString())
    @Published var tagsList = ["국어", "수학", "과학", "사회", "영어", "기타"]
    @Published var tags: [String] = []
    @Published var images: [String] = []
    @Published var isReleased: Bool = true
    @Published var showAlert = false
    var postContent: [String] = []
    
    let serverUrl = ServerUrl.shared
    private var reissueAttempted = false
    
    var disabled: Bool {
        return title.isEmpty || content.text.string.isEmpty || tags.isEmpty
    }
    
    func post() {
        NetworkRunner.shared.request("/post", method: .post, parameters: WritePostRequest(
            title: title,
            content: postContent.joined(separator: "\n"),
            tags: tags,
            images: images,
            isReleased: isReleased
        ), response: GetPostModel.self, isAuthorization: true) { result in
            if case .success(_) = result {
                self.showAlert = true
                self.reissueAttempted = false
            }
        }
    }
}


//MARK: NSString -> string으로
extension NSMutableAttributedString {
    func removingFontAttributes() -> NSMutableAttributedString {
        let mutableCopy = NSMutableAttributedString(attributedString: self)
        mutableCopy.enumerateAttribute(.font, in: NSRange(location: 0, length: mutableCopy.length)) { value, range, _ in
            if value != nil {
                mutableCopy.removeAttribute(.font, range: range)
            }
        }
        return mutableCopy
    }
}

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
    @Published var tags: [String] = ["대구소프트웨어마이스터고"]
    @Published var images: [String] = []
    @Published var isReleased: Bool = true
    @Published var showAlert = false
    var postContent: [String] = []
    var getImageUrl: [URL] {
        images.compactMap { URL(string: $0) }
    }
    
    let serverUrl = ServerUrl.shared
    private var reissueAttempted = false
    
    var disabled: Bool {
        return title.isEmpty || content.text.string.isEmpty || tags.isEmpty
    }
    
    func post() {
        change()
        let plainTextContent = content.text.removingFontAttributes().string
        
        NetworkRunner.shared.request("/post", method: .post, parameters: WritePostRequest(
            title: title,
            content: plainTextContent,
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
    
    //콘텐츠의 텍스트를 Postupload의 텍스트와 교체
    func change() {
        let text = content.text.string
        
        var updatedText = text
        var imageCount = 0
        
        while let range = updatedText.range(of: "📷") { // 📷 이모지 위치 찾기
            if let endRange = updatedText.range(of: "!", range: range.upperBound..<updatedText.endIndex) { // "!"로 끝나는지 확인
                // "📷"로 시작하고 "!"로 끝나는 부분을 잘라냄
                let nextIndex = imageCount < postContent.count ? imageCount : postContent.count - 1
                updatedText.replaceSubrange(range.lowerBound..<endRange.upperBound, with: postContent[nextIndex])
                imageCount += 1 // 다음 요소를 위한 카운트 증가
            } else {
                print("이미지 아님 인식처리 x")
                break
            }
        }
        content.text = NSMutableAttributedString(string: updatedText) // 콘텐츠 텍스트 업데이트
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

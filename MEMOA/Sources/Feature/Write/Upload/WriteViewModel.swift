import Foundation
import _PhotosUI_SwiftUI

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
    var getImageUrl: [URL] {
        images.compactMap { URL(string: $0) }
    }
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
    
    //MARK: 삽입할 이미지
    func insertComment() {
        let mutableAttributedText = NSMutableAttributedString(attributedString: content.text)
        let commentString = NSAttributedString(string: "\n📷\(images.count)번째 이미지가 들어갈 자리에요!\n\n")
        mutableAttributedText.append(commentString)
        
        mutableAttributedText.addAttributes([
            .font: UIFont(name: "Pretendard-Medium", size: 15)!
        ], range: NSMakeRange(0, mutableAttributedText.length))
        content.text = mutableAttributedText
    }
    
    //MARK: 삭제할 이미지
    func deleteComment(index: Int) {
        let commentString = "\n📷\(index + 1)번째 이미지가 들어갈 자리에요!\n\n"
        let mutableAttributedText = NSMutableAttributedString(attributedString: content.text)
        
        if let range = mutableAttributedText.string.range(of: commentString) {
            let nsRange = NSRange(range, in: mutableAttributedText.string)
            mutableAttributedText.deleteCharacters(in: nsRange)
            
            if index < postContent.count {
                postContent.remove(at: index)
            }
        }
        content.text = mutableAttributedText
    }

    //MARK: change 함수 업데이트
    func change() {
        let text = content.text.string
        
        var updatedText = text
        var imageIndex = 0 // postContent와 동기화된 인덱스

        // 자리 표시자 순환 처리
        while let range = updatedText.range(of: "📷") { // "📷" 찾기
            if let endRange = updatedText.range(of: "!", range: range.upperBound..<updatedText.endIndex) { // "!"로 끝나는지 확인
                // 남아있는 postContent와 매칭
                if imageIndex < postContent.count {
                    updatedText.replaceSubrange(range.lowerBound..<endRange.upperBound, with: postContent[imageIndex])
                    imageIndex += 1 // 다음 이미지 처리
                } else {
                    // 남아있는 postContent가 없는 경우 자리 표시자 삭제
                    updatedText.replaceSubrange(range.lowerBound..<endRange.upperBound, with: "")
                }
            } else {
                print("유효하지 않은 자리 표시자 발견")
                break
            }
        }

        // 최종 업데이트된 텍스트를 적용
        content.text = NSMutableAttributedString(string: updatedText)
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

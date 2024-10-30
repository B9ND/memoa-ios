import Foundation
import _PhotosUI_SwiftUI
import Alamofire

class WriteViewModel: ObservableObject {
    // MARK: POST
    @Published var title: String = "" // 타이틀
    @Published var content = ContentItem(text: NSMutableAttributedString())
    @Published var tagsList = ["국어", "수학", "과학", "사회", "영어", "기타"]
    @Published var tags: [String] = []
    @Published var images: [String] = []
    @Published var isReleased: Bool = true
    @Published var showAlert = false
    let serverUrl = ServerUrl.shared
    
    private var token: String {
        return UserDefaults.standard.string(forKey: "access") ?? ""
    }
    
    var disabled: Bool {
        return title.isEmpty || content.text.string.isEmpty || tags.isEmpty
    }
    
    func post() {
        let url = serverUrl.getUrl(for: "/post")
        
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
        ]
        
        let contentWithoutFont = content.text.removingFontAttributes().string
        
        let parameters: [String: Any] = [
            "title": title,
            "content": contentWithoutFont,
            "tags": tags,
            "images": images,
            "isReleased": isReleased
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: GetPostModel.self) { response in
                switch response.result {
                case .success(let response):
                    self.showAlert = true
                    print(response)
                case .failure(let error):
                    if let httpResponse = response.response, httpResponse.statusCode == 403 {
                        RefreshAccessToken.shared.reissue { success in
                            if success {
                                self.post()
                            } else {
                                print("토큰 재발급 실패")
                            }
                        }
                    } else {
                        print(error.localizedDescription)
                    }
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

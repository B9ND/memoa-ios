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
    
    // MARK: 포스트 목록
//    @Published var posts: [GetPostModel] = []
    
//    // MARK: GET
//    @Published var id: Int = 300
//    @Published var author: String = ""
//    @Published var getContent: String = ""
//    @Published var getTitle: String = ""
//    @Published var getTags: [String] = []
//    @Published var createdAt = ""
//    @Published var getImages: [String] = []
//    var getImageUrl: [URL] {
//        getImages.compactMap { URL(string: $0) }
//    }
    
    var disabled: Bool {
        return title.isEmpty || content.text.string.isEmpty || tags.isEmpty
    }
    
    func post() {
        let url = serverUrl.getUrl(for: "/post")
        
        let token = "eyJhbGciOiJIUzI1NiJ9.eyJjYXRlZ29yeSI6ImFjY2VzcyIsImVtYWlsIjoia2ltZXVuY2hhbjI4MTVAZ21haWwuY29tIiwicm9sZSI6IlJPTEVfVVNFUiIsImRldmljZSI6Ik1vemlsbGEvNS4wIChNYWNpbnRvc2g7IEludGVsIE1hYyBPUyBYIDEwXzE1XzcpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMjguMC4wLjAgU2FmYXJpLzUzNy4zNl8yMjEuMTY4LjIyLjIwNSIsImlhdCI6MTcyOTczMzYwOSwiZXhwIjoxNzI5NzM0MjA5fQ.uRjR4k5g-d6l4MVU8LfqyPPQG2WR4TLlLXy9eQg_4D0"
        
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
                    print(error)
                }
            }
    }
    
    //MARK: 아이디로 받아옴
    //get postitem
//    func getPost() {
//        let url = serverUrl.getUrl(for: "/post/\(id)")
//
//        
//        let token = "eyJhbGciOiJIUzI1NiJ9.eyJjYXRlZ29yeSI6ImFjY2VzcyIsImVtYWlsIjoibGVlZ2VoMTIxM0BnbWFpbC5jb20iLCJyb2xlIjoiUk9MRV9VU0VSIiwiZGV2aWNlIjoiTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTVfNykgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEyOC4wLjAuMCBTYWZhcmkvNTM3LjM2XzIyMS4xNjguMjIuMjA1IiwiaWF0IjoxNzI5NTk5MTY0LCJleHAiOjE3Mjk1OTk3NjR9.fOs9qzcA4RI15XwK04mUUBKoPY-zMXSCDv7O8TweDJ0"
//        
//        let headers: HTTPHeaders = [
//            "Authorization": "Bearer \(token)",
//        ]
//        
//        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
//            .responseDecodable(of: GetPostModel.self) { reponse in
//                switch reponse.result {
//                case .success(let response):
//                    let newPost = GetPostModel(
//                        id: response.id,
//                        title: response.title,
//                        content: response.content,
//                        author: response.author,
//                        tags: response.tags,
//                        createdAt: response.createdAt,
//                        images: response.images
//                    )
//                    self.id = response.id
//                    self.posts.append(newPost)
//                    print(response)
//                case .failure(let error):
//                    print(error)
//                }
//            }
//    }
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

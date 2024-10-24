import Foundation
import UIKit
import Alamofire

//MARK: 이미지서버로 업로드
class ImageViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var imageUrl: String?
    let serverUrl = ServerUrl.shared
    
    func getImageUrl(completion: @escaping(String?) -> Void) {
        let url = serverUrl.getUrl(for: "/image/upload")
        
        guard let image = image else {
            print("이미지가 없습니다.")
            return
        }
        
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            print("이미지 데이터를 변환하는 데 실패했습니다.")
            return
        }
        
        
        let token = "eyJhbGciOiJIUzI1NiJ9.eyJjYXRlZ29yeSI6ImFjY2VzcyIsImVtYWlsIjoia2ltZXVuY2hhbjI4MTVAZ21haWwuY29tIiwicm9sZSI6IlJPTEVfVVNFUiIsImRldmljZSI6Ik1vemlsbGEvNS4wIChNYWNpbnRvc2g7IEludGVsIE1hYyBPUyBYIDEwXzE1XzcpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMjguMC4wLjAgU2FmYXJpLzUzNy4zNl8yMjEuMTY4LjIyLjIwNSIsImlhdCI6MTcyOTczMzYwOSwiZXhwIjoxNzI5NzM0MjA5fQ.uRjR4k5g-d6l4MVU8LfqyPPQG2WR4TLlLXy9eQg_4D0"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
        }, to: url, headers: headers)
        .responseString { response in
            switch response.result {
            case .success(let responseString):
                DispatchQueue.main.async {
                    self.imageUrl = responseString.trimmingCharacters(in: .whitespacesAndNewlines)
                    completion(self.imageUrl)
                }
            case .failure(let error):
                print("업로드 실패: \(error.localizedDescription)")
            }
        }
    }
}

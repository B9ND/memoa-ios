import Foundation
import UIKit
import Alamofire

//MARK: 이미지서버로 업로드
class ImageViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var imageUrl: String?
    let serverUrl = ServerUrl.shared
    let tokenUrl = TokenUrl.shared
    //MARK: 임시방편
    
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
        
        
        let token = tokenUrl.token
        
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

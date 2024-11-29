import Foundation
import UIKit
import Alamofire

//MARK: 이미지서버로 업로드
class ImageViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var imageUrl: String?
    
    func getImageUrl(completion: @escaping(String?) -> Void) {
        guard let image else {
            print("이미지가 없습니다.")
            return
        }
        
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            print("이미지 데이터를 변환하는 데 실패했습니다.")
            return
        }
        
        NetworkRunner.shared.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")}, to: "/image/upload", response: ImageResponse.self) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.imageUrl = data.url
                        completion(self.imageUrl)
                    }
                case .failure(let error):
                    completion(nil)
                    dump(error)
                }
            }
    }
}

struct ImageResponse: Decodable {
    let url: String
}

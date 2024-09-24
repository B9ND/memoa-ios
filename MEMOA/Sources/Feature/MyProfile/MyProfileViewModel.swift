import Foundation

class MyProfileViewModel: ObservableObject {
    @Published var request: MyProfileModel
    
    init() {
        let exampleurlimage = "https://picsum.photos/200"
        self.request = MyProfileModel(image: [
            UploadMyimage(imageurl: exampleurlimage),
            UploadMyimage(imageurl: exampleurlimage),
            UploadMyimage(imageurl: exampleurlimage),
            UploadMyimage(imageurl: exampleurlimage),
        ])
    }
//    func shuffleImages() {
//           request.image.shuffle()
//       }
}

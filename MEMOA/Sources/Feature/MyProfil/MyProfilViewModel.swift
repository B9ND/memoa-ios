import Foundation

class MyProfilViewModel: ObservableObject {
    @Published var request: MyProfilModel
    
    init() {
        let exampleurlimage = "https://picsum.photos/200"
        self.request = MyProfilModel(image: [
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

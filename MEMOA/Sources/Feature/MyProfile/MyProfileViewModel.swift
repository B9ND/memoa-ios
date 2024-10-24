import Foundation

class MyProfileViewModel: ObservableObject {
    @Published var name: String = "박재민"
    @Published var email: String = "pjmin0923@gmail.com"
    @Published var image: [UploadMyimage]
    

    init() {
        let exampleurlimage = "https://picsum.photos/200"
        self.image = [
            UploadMyimage(imageurl: exampleurlimage),
            UploadMyimage(imageurl: exampleurlimage),
            UploadMyimage(imageurl: exampleurlimage),
            UploadMyimage(imageurl: exampleurlimage),
        ]
    }
    //이미지 섞음
//    func shuffleImages() {
//        image.shuffle()
//    }
}

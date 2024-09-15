import Foundation

class ProfilViewmodel: ObservableObject {
    @Published var request: ProfilModel
    
    init() {
        let exampleurlimage = "https://picsum.photos/200"
        self.request = ProfilModel(image: [
            Uploadimage(imageurl: exampleurlimage),
            Uploadimage(imageurl: exampleurlimage),
            Uploadimage(imageurl: exampleurlimage),
            Uploadimage(imageurl: exampleurlimage),
            Uploadimage(imageurl: exampleurlimage)
        ])
    }
//    func shuffleImages() {
//           request.image.shuffle()
//       }
}

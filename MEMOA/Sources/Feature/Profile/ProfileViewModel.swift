import Foundation

class ProfileViewModel: ObservableObject {
    @Published var image: [Uploadimage]
    
    init() {
        let exampleurlimage = "https://picsum.photos/200"
        self.image = [
            Uploadimage(imageurl: exampleurlimage),
            Uploadimage(imageurl: exampleurlimage),
            Uploadimage(imageurl: exampleurlimage),
            Uploadimage(imageurl: exampleurlimage)
        ]
    }
}

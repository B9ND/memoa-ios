import Foundation

class ProfileViewModel: ObservableObject {
    @Published var request: ProfileModel
    
    init() {
        let exampleurlimage = "https://picsum.photos/200"
        self.request = ProfileModel(image: [
            Uploadimage(imageurl: exampleurlimage),
            Uploadimage(imageurl: exampleurlimage),
            Uploadimage(imageurl: exampleurlimage),
            Uploadimage(imageurl: exampleurlimage)
        ])
    }
}

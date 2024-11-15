import Foundation

class BookmarkViewModel: ObservableObject {
    @Published var isBoomark = false
    
    func bookmark(id: Int) {
//        NetworkRunner.shared.bookmark("/bookmark", method: .post, parameters: ["post-id" : id], isAuthorization: true) { result in
//            switch result {
//            case .success():
//                self.isBoomark = true
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    func deleteBookmark(id: Int) {
//        NetworkRunner.shared.bookmark("/bookmark", method: .delete, parameters: ["post-id" : id], isAuthorization: true) { result in
//            switch result {
//            case .success():
//                self.isBoomark = false
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
}

import Foundation

//TODO: 스웨거 나오는데로 수정
class CommentViewModel: ObservableObject {
    @Published var ChatList: [CommentBoardModel] = []
}

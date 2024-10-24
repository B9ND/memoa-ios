//
//  ChatView.swift
//  MEMOA
//
//  Created by dgsw30 on 10/17/24.
//

import SwiftUI
//MARK: comment

struct CommentView: View {
    var body: some View {
        //MARK: board 다시 만들까 고민중임
        VStack {
            ForEach(1..<5) { _ in
                CommentViewCell(board: BoardModel(nickname: "김은찬", time: "2024-10-18", image: [], title: "공유", tag: "" , email: "fsdlfksj"))
            }
        }
        .padding(.vertical, 14)
        Spacer()
        PostCommentCell()
        BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .black)
    }
}

#Preview {
    CommentView()
}

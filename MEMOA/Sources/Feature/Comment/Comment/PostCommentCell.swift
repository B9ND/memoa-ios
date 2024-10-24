//
//  PostChatCell.swift
//  MEMOA
//
//  Created by dgsw30 on 10/18/24.
//

import SwiftUI
//MARK: 댓글 textfield
struct PostCommentCell: View {
    @State private var text = ""
    //MARK: 수정
    var body: some View {
            VStack {
                Divider()
                HStack {
                    Image(icon: .mediumProfile)
                    TextField("댓글을 입력해보세요!", text: $text, axis: .vertical)
                        .frame(width: 253, height: 35)
                        .tint(.maincolor)
                        .padding(.horizontal, 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.graycolor)
                        )
                    Button {
                        //MARK: uploadChat 구현
                    } label: {
                        Image(icon: .uploadChat)
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    
                }
            }
    }
}

#Preview {
    PostCommentCell()
}

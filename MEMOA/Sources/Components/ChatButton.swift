//
//  ChatButton.swift
//  MEMOA
//
//  Created by dgsw30 on 10/17/24.
//

import SwiftUI
//MARK: 채팅버튼
struct ChatButton: View {
    @State private var toChat = false
    var body: some View {
        Button {
            toChat.toggle()
        } label: {
            Image(.chat)
                .foregroundStyle(.timecolor)
        }
        .navigationDestination(isPresented: $toChat) {
            CommentView()
        }
    }
}

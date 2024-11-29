//
//  ChatButton.swift
//  MEMOA
//
//  Created by dgsw30 on 10/17/24.
//

import SwiftUI
//MARK: 채팅버튼
struct ChatButton: View {
    @State private var chatAlert = false
    var body: some View {
        Button {
            chatAlert = true
        } label: {
            Image(.chat)
                .foregroundStyle(.timecolor)
        }
        .alert("아직 준비중인 기능입니다.", isPresented: $chatAlert) {
            Button("OK", role: .cancel) {}
        }
    }
}

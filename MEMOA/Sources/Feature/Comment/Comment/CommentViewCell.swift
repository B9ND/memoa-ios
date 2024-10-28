//
//  ChatViewCell.swift
//  MEMOA
//
//  Created by dgsw30 on 10/18/24.
//

import SwiftUI
//MARK: chatcomponent

struct CommentViewCell: View {
    @State private var toProfile = false
    var board: BoardModel
    var body: some View {
        VStack {
            HStack {
                ProfileButton(type: .detail) {
                    toProfile = true
                }
                .padding(.leading, 24)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(board.nickname)
                            .foregroundStyle(.black)
                            .font(.medium(16))
                        Circle()
                            .frame(width: 5, height: 4)
                            .tint(Color(uiColor: .systemGray3))
                        Text(board.time)
                            .font(.medium(14))
                            .foregroundColor(.timecolor)
                    }
                    .padding(.vertical, 2)
                    
                    Text(board.title)
                        .foregroundColor(.timecolor)
                        .font(.regular(16))
                }
                Spacer()
            }
            Divider()
                .padding(.vertical, 3)
        }
        .navigationDestination(isPresented: $toProfile) {
            ProfileView(board: board)
        }
    }
}

//
//  ProfileButton.swift
//  MEMOA
//
//  Created by dgsw30 on 10/18/24.
//

import SwiftUI
//MARK: 프로필로 이동하는 버튼
struct ProfileButton: View {
    let action: () -> Void
    let image: String
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Image(image)
        })
    }
}

//
//  ChangeName.swift
//  MEMOA
//
//  Created by dgsw30 on 9/19/24.
//

//TODO: 이름 수정
import SwiftUI

struct ChangeNameView: View {
    @State private var changename = ""
    @Environment (\.dismiss) private var dismiss
    var body: some View {
        VStack {
            TextField("변경할 이름을 입력해주세요", text: $changename)
                .tint(.maincolor)
                .padding(.horizontal,16)
                    Rectangle()
                        .fill(.black)
                        .frame(width: 325,height: 1)
        }
        .padding()
        Spacer()
        BackButton(text: "뒤로가기", systemImageName: "chevron.left")
        CompleteButton {
            print("완료")
        }
    }
}

#Preview {
    ChangeNameView()
}
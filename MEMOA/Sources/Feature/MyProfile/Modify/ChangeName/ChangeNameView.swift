//
//  ChangeName.swift
//  MEMOA
//
//  Created by dgsw30 on 9/19/24.
//

//MARK: 이름 수정
import SwiftUI

struct ChangeNameView: View {
    @ObservedObject var changeNameVM: ModifyViewModel
    var body: some View {
        VStack {
            TextField("변경할 이름을 입력해주세요", text: $changeNameVM.changeName)
                .tint(.maincolor)
                .padding(.horizontal, 16)
            Rectangle()
                .fill(.black)
                .frame(width: 325,height: 1)
        }
        .padding()
        Spacer()
            .onAppear {
                changeNameVM.changeName = ""
            }
            .addBackButton(text: "이름 변경", systemImageName: "chevron.left", fontcolor: .black)
        CompleteButton(action: {
            changeNameVM.changeUserName()
        }, bool: changeNameVM.changeName.isEmpty, Title: "이름이 변경되었어요!", SubTitle: nil, alertBool: $changeNameVM.nameAlert)
    }
}

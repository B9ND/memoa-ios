//
//  ChangeDesciptionView.swift
//  MEMOA
//
//  Created by dgsw30 on 11/7/24.
//

import SwiftUI

//MARK: 유저 소개 수정
struct ChangeDesciptionView: View {
    @ObservedObject var changeDescriptionVM: ModifyViewModel
    var body: some View {
        VStack {
            TextField("변경할 자기소개 입력해주세요", text: $changeDescriptionVM.changeDescription)
                .tint(.maincolor)
                .padding(.horizontal, 16)
                    Rectangle()
                        .fill(.black)
                        .frame(width: 325,height: 1)
        }
        .padding()
        Spacer()
            .onAppear {
                changeDescriptionVM.changeDescription = ""
            }
        BackButton(text: "자기소개 변경", systemImageName: "chevron.left", fontcolor: .black)
        CompleteButton(action: {
            changeDescriptionVM.changeUserDescription()
        }, bool: changeDescriptionVM.changeDescription.isEmpty, Title: "자기소개가 변경되었어요!", SubTitle: nil, alertBool: $changeDescriptionVM.descriptionAlert)
    }
}

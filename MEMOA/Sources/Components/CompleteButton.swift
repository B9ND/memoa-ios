//
//  CompleteButton.swift
//  MEMOA
//
//  Created by dgsw30 on 9/19/24.
//

import SwiftUI

struct CompleteButton: ViewModifier {
    @Binding var alertBool: Bool
    @Environment(\.dismiss) private var dismiss
    let action: () -> Void
    let bool: Bool
    let Title: String
    let SubTitle: String?
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        action()
                    }) {
                        HStack {
                            Text("완료")
                                .font(.bold(16))
                                .foregroundStyle(bool ? Color.graycolor : .maincolor)
                                .padding(.trailing, 14)
                        }
                    }
                    .disabled(bool)
                }
            }
            .alert("\(Title)", isPresented: $alertBool, actions: {
                Button("확인") {
                    dismiss()
                }
            }, message: {
                Text("\(SubTitle ?? "")")
            })
    }
}

extension View {
    func completeButton(
        isAlert: Binding<Bool>,
        Title: String,
        SubTitle: String?,
        action: @escaping () -> Void,
        isComplete: Bool
    ) -> some View {
        self.modifier(
            CompleteButton(
                alertBool: isAlert,
                action: action,
                bool: isComplete,
                Title: Title,
                SubTitle: SubTitle
            )
        )
    }
}



//
//  CompleteButton.swift
//  MEMOA
//
//  Created by dgsw30 on 9/19/24.
//

import SwiftUI

struct CompleteButton: View {
    let action: () -> Void
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        HStack {
            EmptyView()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    action()
                }) {
                    HStack {
                        Text("완료")
                        .font(.bold(16))
                        .foregroundColor(.maincolor)
                        .padding(.trailing, 14)
                    }
                }
            }
        }
    }
}

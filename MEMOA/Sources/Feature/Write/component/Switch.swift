//
//  Switch.swift
//  MEMOA
//
//  Created by dgsw30 on 10/17/24.
//

import SwiftUI

struct Switch: View {
    @Binding var bool: Bool
    var body: some View {
        //공개 스위치
        HStack {
            Text("우리학교만 공개")
                .font(.regular(14))
            ZStack(alignment: bool ? .leading : .trailing) {
                Rectangle()
                    .frame(width: 34, height: 14)
                    .foregroundStyle(bool ? Color.gray.opacity(0.2) : Color.purple.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                    .onTapGesture {
                        withAnimation(.spring(duration: 0.25)) {
                            bool.toggle()
                        }
                    }
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(bool ? .white : Color.togglecolor)
                    .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)
            }
            Spacer()
        }
    }
}

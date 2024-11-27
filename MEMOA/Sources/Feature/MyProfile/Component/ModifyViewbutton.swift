//
//  ModifyViewbutton.swift
//  MEMOA
//
//  Created by dgsw30 on 9/5/24.
//

//MARK: 설정 이용약관등 이동 버튼
import SwiftUI

struct ModifyViewbutton: View {
    let text: String
    let action: () -> Void
    let color: Color
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                HStack {
                    Text(text)
                        .foregroundColor(color)
                        .font(.regular(16))
                        .padding()
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                        .padding()
                }
                .frame(width: 318,height: 53)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(
                    color: Color(.sRGBLinear, white: 0, opacity: 0.1),
                    radius: 0.5, x: 0.5, y: 1
                )
//                .shadow(
//                            color: Color.black.opacity(0.1), // 색상과 투명도 조정
//                            radius: 2, // 반경을 늘려 부드럽게
//                            x: 0, // x 위치 조정
//                            y: 2 // y 위치 조정
//                        )
            }
            .padding(.vertical, 5)
        }
    }
}

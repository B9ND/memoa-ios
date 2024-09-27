//
//  ChangingDepartment.swift
//  MEMOA
//
//  Created by dgsw30 on 9/19/24.
//

import SwiftUI

struct ChangingDepartmentView: View {
    @State private var findSchool = ""
    var body: some View {
        VStack {
            HStack {
                Image(icon: .search)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22)
                    .padding(.leading, 11)
                TextField("소속학교를 검색하세요", text: $findSchool)
                    .foregroundColor(.black)
            }
            .frame(width: 324, height: 36)
            .background(.white)
            .cornerRadius(50)
            .shadow(radius: 2, y: 1)
            .padding(.top, 38)
            .padding(.bottom, 18)
        }
        BackButton(text: "소속변경", systemImageName: "chevron.left", fontcolor: .black)
        CompleteButton {
            print("완료")
        }
    }
}

#Preview {
    ChangingDepartmentView()
}

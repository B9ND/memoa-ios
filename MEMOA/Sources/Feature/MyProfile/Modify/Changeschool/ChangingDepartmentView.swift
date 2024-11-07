//
//  ChangingDepartment.swift
//  MEMOA
//
//  Created by dgsw30 on 9/19/24.
//

import SwiftUI
//MARK: 학교변경

struct ChangingDepartmentView: View {
    @StateObject var changeVM = ChangeDepartmentViewModel()
    @State private var findSchool = ""
    var body: some View {
        VStack(spacing: 0) {
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
            
            ForEach(changeVM.findSchool, id: \.self) { school in
                Button(action: {
                }, label: {
                    HStack {
                        Text(school.schoolname)
                            .foregroundColor(.black)
                            .font(.light(16))
                            .padding(.leading, 17)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 47)
                    .background(.white)
                    .border(Color.gray.opacity(0.2))
                })
            }
        }
        Spacer()
        BackButton(text: "소속변경", systemImageName: "chevron.left", fontcolor: .black)
//        CompleteButton(action: {
//            print("소속변경")
//        }, bool: changeVM.findSchool.isEmpty)
        //이거 수정
    }
}

#Preview {
    ChangingDepartmentView()
}

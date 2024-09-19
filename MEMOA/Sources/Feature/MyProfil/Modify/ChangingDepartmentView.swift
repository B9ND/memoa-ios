//
//  ChangingDepartment.swift
//  MEMOA
//
//  Created by dgsw30 on 9/19/24.
//

import SwiftUI

struct ChangingDepartmentView: View {
    var body: some View {
        VStack {
            Text("z")
        }
        BackButton(text: "뒤로가기", systemImageName: "chevron.left")
        CompleteButton {
            print("완료")
        }
    }
}

#Preview {
    ChangingDepartmentView()
}
